//
//  NewIncomeInteractor.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 27.12.2021.
//

import Foundation
import CoreData

class NewIncomeInteractor: NewIncomeInteractorType {
    
    var presenter: NewIncomePresenterType?
    
    var coreDataManager = CoreDataManager.shared
    
    func fetchUserData() {
        
        DispatchQueue.main.async { [unowned self] in
            
            let wallets = self.fetchUserWalletsWithCurrentBalance()
            
            switch wallets {
                
            case .success(let wallets):
                
                presenter?.userDataWalletsIsFetched(result: .success(wallets))
                
            case .failure(let error):
                
                presenter?.userDataWalletsIsFetched(result: .failure(error))
                
            }
            
            
            
        }
        
        DispatchQueue.main.async { [unowned self] in
            
            let categories = self.fetchUserSelectedCategories()
            
            switch categories {
                
            case .success(let categories):
                
                presenter?.userDataCategoriesIsFetched(result: .success(categories))
                
            case .failure(let error):
                
                presenter?.userDataCategoriesIsFetched(result: .failure(error))
                
            }
            
        }
    }
    
    func fetchUserWalletsWithCurrentBalance() -> Result<[GeneralWalletModel], Errors> {
        
        var wallets = [GeneralWalletModel]()
        
        let walletsMO = coreDataManager.getUserWallets()
        
        switch walletsMO {
            
        case .success(let walletsMO):
            
            for walletMO in walletsMO {
                
                guard walletMO.isActive else { continue }
                
                let startBalanceMO = walletMO.balance
                let walletName = walletMO.walletName
                
                guard let startBalanceMO = startBalanceMO,
                      let walletName = walletName else { return .failure(Errors.loadWalletsError) }
                
                var totalBalance = startBalanceMO as Decimal
                
                let transactions = coreDataManager.getTransactionsForWallet(wallet: walletMO)
                
                switch transactions {
                    
                case .success(let transactions):
                    
                    for transaction in transactions {
                        
                        let moneyChange = transaction.amount as Decimal?
                        let categoryID = transaction.categoryID
                        
                        guard let moneyChange = moneyChange,
                              let categoryID = categoryID else { return .failure(Errors.loadTransactionsError) }
                        
                        if categoryID.isExpenseCategoryID() {
                            totalBalance -= moneyChange
                        } else {
                            totalBalance += moneyChange
                        }
                        
                    }
                    
                    wallets.append(GeneralWalletModel(walletName: walletName,
                                                      icon: nil,
                                                      balance: totalBalance))

                    
                case .failure(let error):
                    
                    return .failure(error)
                    
                }
            }
            
            return .success(wallets)
            
        case .failure(let error):
            
            return .failure(error)
            
        }

    }
    
    func fetchUserSelectedCategories() -> Result<[GeneralCategoryModel], Errors> {
        
        var categories = [GeneralCategoryModel]()
        
        let userSettings = coreDataManager.getUserSettings()
        
        switch userSettings {
            
        case .success(let userSettings):
            
            let userIncomeCategories = userSettings.incomeCategoriesID
            
            guard let userIncomeCategories = userIncomeCategories else { return .failure(Errors.loadUserSettingsError) }
            
            for userIncomeCategory in userIncomeCategories {
                
                for incomeCategory in incomeCategories {
                    
                    if incomeCategory.categoryID == userIncomeCategory {
                        
                        categories.append(incomeCategory)
                        
                    }
                    
                }
                
            }
            
            return .success(categories)
            
        case .failure(let error):
            
            return .failure(error)
            
        }
        
    }
    
    func saveTransaction(walletName: String,
                         categoryID: String,
                         transactionDetail: String?,
                         amount: Decimal) -> Result<String, Errors> {
        
        let transaction = Transaction()
        transaction.date = Date()
        transaction.detail = transactionDetail
        transaction.categoryID = categoryID
        transaction.amount = amount.round() as NSDecimalNumber
        
        let wallets = coreDataManager.getUserWallets()
        
        switch wallets {
            
        case .success(let wallets):
            
            for wallet in wallets {
                
                guard let walletMOWalletName = wallet.walletName else { return .failure(Errors.loadWalletsError) }
                
                if walletMOWalletName == walletName {
                    
                    wallet.addToTransactions(transaction)
                    transaction.wallet = wallet
                    
                }
                
            }
            
            coreDataManager.saveContext()
            
            return .success("success")
            
        case .failure(let error):
            
            return .failure(error)
            
        }
        
    }
    
}
