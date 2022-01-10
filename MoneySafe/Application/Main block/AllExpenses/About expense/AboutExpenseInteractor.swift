//
//  AboutExpenseInteractor.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 01.01.2022.
//

import Foundation

class AboutExpenseInteractor: AboutExpenseInteractorType {

    var presenter: AboutExpensePresenterType?
    
    var selectedTransaction: Transaction!
    
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
        
        DispatchQueue.main.async { [unowned self] in
            
            let result = self.getSelectedTransactionData()
            
            self.presenter?.transactionDataIsFetched(result: result)
            
        }
    }
    
    func saveChanges(walletName: String,
                     categoryID: String,
                     transactionDetail: String?,
                     amount: Decimal,
                     date: Date) -> Result<String, Errors> {
        
        deleteSelectedTransaction()
        
        let transaction = Transaction()
        transaction.date = Date()
        transaction.detail = transactionDetail
        transaction.categoryID = categoryID
        transaction.amount = amount.round() as NSDecimalNumber
        transaction.date = date
        
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
    
    func deleteSelectedTransaction() {
        coreDataManager.deleteTransaction(selectedTransaction)
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
            
            var selectedCategories: [String]?
            
            if selectedTransaction.categoryID!.isExpenseCategoryID() {
                selectedCategories = userSettings.expenseCategoriesID
            } else {
                selectedCategories = userSettings.incomeCategoriesID
            }
            
            guard let selectedCategories = selectedCategories else { return .failure(Errors.loadUserSettingsError) }
            
            for selectedCategory in selectedCategories {
                
                if selectedCategory.isExpenseCategoryID() {
                    
                    for expenseCaregory in expenseCaregories {
                        
                        if expenseCaregory.categoryID == selectedCategory {
                            
                            categories.append(expenseCaregory)
                            
                        }
                        
                    }
                    
                } else {
                    
                    for incomeCategory in incomeCategories {
                        
                        if incomeCategory.categoryID == selectedCategory {
                            
                            categories.append(incomeCategory)
                            
                        }
                        
                    }
                    
                }
                
            }
            
            return .success(categories)
            
        case .failure(let error):
            
            return .failure(error)
            
        }
        
    }
    
    func getSelectedTransactionData() -> GeneralTransactionModel {
        
        var currentCategory: GeneralCategoryModel!
        
        if selectedTransaction.categoryID!.isExpenseCategoryID() {
            for category in expenseCaregories where category.categoryID == selectedTransaction.categoryID! {
                currentCategory = category
            }
        } else {
            for category in incomeCategories where category.categoryID == selectedTransaction.categoryID! {
                currentCategory = category
            }
        }
        
        return GeneralTransactionModel(category: currentCategory,
                                       descriptionText: selectedTransaction.detail!,
                                       amount: selectedTransaction.amount! as Decimal,
                                       date: selectedTransaction.date!,
                                       walletName: selectedTransaction.wallet!.walletName!,
                                       transactionMO: selectedTransaction)
        
    }
    
    func getSelectedTransactionWalletName() -> String {
        return selectedTransaction.wallet!.walletName!
    }
    
    func getSelectedCategoryID() -> String {
        return selectedTransaction.categoryID!
    }
    
}
