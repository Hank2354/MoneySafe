//
//  MainInteractor.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 27.12.2021.
//

import Foundation
import CoreData

class MainInteractor: MainInteractorType {

    var presenter: MainPresenterType?
    
    var coreDataManager = CoreDataManager.shared
    var dateManager = DateManager.shared
    
    func fetchUserData() {
        let balance = getTotalBalance()
        let budgets = getbudgetsWithTransactions()
        let month = getCurrentMouth()
        
        switch balance {
            
        case .success(let balance):
            
            switch budgets {
                
            case .success(let budgets):
                
                presenter?.userDataIsFetched(totalBalance: balance,
                                             budgetsWithTransactions: budgets,
                                             currentMonth: month,
                                             error: nil)
                
            case .failure(let error):
                
                presenter?.userDataIsFetched(totalBalance: nil,
                                             budgetsWithTransactions: nil,
                                             currentMonth: nil,
                                             error: error)
                
            }
            
        case .failure(let error):
            
            presenter?.userDataIsFetched(totalBalance: nil,
                                         budgetsWithTransactions: nil,
                                         currentMonth: nil,
                                         error: error)
            
        }

    }
    
    func getCurrentMouth() -> String {
        return dateManager.getMonthString(nil)
    }
    
    func getTotalBalance() -> Result<Decimal, Errors> {
        
        var totalBalance: Decimal = 0
        
        let userWallets = coreDataManager.getUserWallets()
        
        switch userWallets {
            
        case.success(let userWallets):
            
            for wallet in userWallets {
                
                guard wallet.isActive else { continue }
                
                let walletStartBalance = wallet.balance as Decimal?
                
                guard let walletStartBalance = walletStartBalance else { return .failure(Errors.loadWalletsError) }
                
                totalBalance += walletStartBalance
                
                let transactions = coreDataManager.getTransactionsForWallet(wallet: wallet)
                
                switch transactions {
                    
                case.success(let transactions):
                    
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
                    
                case .failure(let error):
                    
                    return .failure(error)
                    
                }

                
            }
            
            return .success(totalBalance)
            
        case .failure(let error):
            
            return .failure(error)
            
        }

    }
    
    func getbudgetsWithTransactions() -> Result<[GeneralActualBudgetModel], Errors> {
        
        var result = [GeneralActualBudgetModel]()
        
        let budgetUnits = coreDataManager.getUserBudgetUnits()
        let transactions = coreDataManager.getAllTransactions()
        
        switch budgetUnits {
            
        case .success(let budgetUnits):
            
            switch transactions {
                
            case .success(let transactions):
                
                for budgetUnit in budgetUnits {
                    
                    let categoryID = budgetUnit.categoryID
                    var category: GeneralCategoryModel!
                    var spentMoney: Decimal = 0
                    
                    guard let categoryID = categoryID else { return .failure(Errors.loadUserBudgetsError) }
                    
                    for expenseCaregory in expenseCaregories {
                        if expenseCaregory.categoryID == categoryID {
                            category = expenseCaregory
                        }
                    }
                    
                    for transaction in transactions {
                        
                        guard let transactionCategoryID = transaction.categoryID else { return .failure(Errors.loadTransactionsError) }
                        guard let transactionDate = transaction.date else { return .failure(Errors.loadTransactionsError) }
                        
                        let transactionMonth = dateManager.getMonthString(transactionDate)
                        let currentMonth = dateManager.getMonthString(nil)
                        
                        if transactionCategoryID == categoryID,
                           transactionMonth == currentMonth {
                            
                            guard let amount = transaction.amount else { return .failure(Errors.loadTransactionsError) }
                            
                            let decimalAmount = amount as Decimal
                            
                            spentMoney += decimalAmount
                            
                        }
                    }
                    
                    guard let budget = budgetUnit.budget else { return .failure(.loadUserBudgetsError) }
                    let decimalBudget = budget as Decimal
                    
                    result.append(GeneralActualBudgetModel(category: category,
                                                            budget: decimalBudget,
                                                            totalExpenses: spentMoney))
                }
                
            case .failure(let error):
                
                return .failure(error)
                
            }
            
            
        case .failure(let error):
            
            return .failure(error)
            
        }

        
        
        return .success(result)
    }
    
    
}
