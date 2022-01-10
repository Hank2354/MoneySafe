//
//  AllExpensesInteractor.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 30.12.2021.
//

import Foundation

class AllExpensesInteractor: AllExpensesInteractorType {
    
    var presenter: AllExpensesPresenterType?
    
    let coreDataManager = CoreDataManager.shared
    let dateManager = DateManager.shared
    
    func getTransactionData() {
        let transactions = coreDataManager.getAllTransactions()
        
        switch transactions {
            
        case .success(let transactions):
            
            var todayTransactions = [GeneralTransactionModel]()
            var tomorrowTransactions = [GeneralTransactionModel]()
            var currentMonthTransactions = [GeneralTransactionModel]()
            var otherTransactions = [GeneralTransactionModel]()
            
            let todayDate = dateManager.getDateModel(Date())
            let tomorrowDate = dateManager.getTomorrowDate(Date())
            
            for transaction in transactions {
                
                guard let transactionDate = transaction.date,
                      let transactionCategoryID = transaction.categoryID,
                      let transactionDescription = transaction.detail,
                      let transactionAmount = transaction.amount,
                      let transactionWalletName = transaction.wallet?.walletName else {
                    
                    presenter?.isTransactionDataFethed(data: nil, error: .loadTransactionsError)
                    return
                          
                }
                
                let currentTransactionDate = dateManager.getDateModel(transactionDate)
                
                var currentCategory: GeneralCategoryModel?
                
                if transactionCategoryID.isExpenseCategoryID() {
                    
                    for category in expenseCaregories {
                        
                        if transactionCategoryID == category.categoryID {
                            
                            currentCategory = category
                            
                        }
                        
                    }
                    
                } else {
                    
                    for category in incomeCategories {
                        
                        if transactionCategoryID == category.categoryID {
                            
                            currentCategory = category
                            
                        }
                        
                    }
                    
                }
                
                guard let currentCategory = currentCategory else {
                    
                    presenter?.isTransactionDataFethed(data: nil, error: .loadTransactionsError)
                    
                    return
                    
                }
                
                //
                if currentTransactionDate.day == todayDate.day,
                   currentTransactionDate.mouth == todayDate.mouth,
                   currentTransactionDate.year == todayDate.year {
                    
                    todayTransactions.append(GeneralTransactionModel(category: currentCategory,
                                                                     descriptionText: transactionDescription,
                                                                     amount: transactionAmount as Decimal,
                                                                     date: transactionDate,
                                                                     walletName: transactionWalletName,
                                                                     transactionMO: transaction))
                    
                } else if currentTransactionDate.day == tomorrowDate.day,
                          currentTransactionDate.mouth == tomorrowDate.mouth,
                          currentTransactionDate.year == tomorrowDate.year {
                    
                    tomorrowTransactions.append(GeneralTransactionModel(category: currentCategory,
                                                                        descriptionText: transactionDescription,
                                                                        amount: transactionAmount as Decimal,
                                                                        date: transactionDate,
                                                                        walletName: transactionWalletName,
                                                                        transactionMO: transaction))
                    
                } else if currentTransactionDate.mouth == todayDate.mouth,
                          currentTransactionDate.year == todayDate.year {
                    
                    currentMonthTransactions.append(GeneralTransactionModel(category: currentCategory,
                                                                            descriptionText: transactionDescription,
                                                                            amount: transactionAmount as Decimal,
                                                                            date: transactionDate,
                                                                            walletName: transactionWalletName,
                                                                            transactionMO: transaction))
                    
                } else {
                    
                    otherTransactions.append(GeneralTransactionModel(category: currentCategory,
                                                                     descriptionText: transactionDescription,
                                                                     amount: transactionAmount as Decimal,
                                                                     date: transactionDate,
                                                                     walletName: transactionWalletName,
                                                                     transactionMO: transaction))
                    
                }
                //
            }
            
            let sortedTodayTransactions = todayTransactions.sorted { $0.date > $1.date }
            let sortedTomorrowTransactions = tomorrowTransactions.sorted { $0.date > $1.date }
            let sortedCurrentMonthTransactions = currentMonthTransactions.sorted { $0.date > $1.date }
            let sortedOtherTransactions = otherTransactions.sorted { $0.date > $1.date }
            
            let separatedTransactions = [
                sortedTodayTransactions,
                sortedTomorrowTransactions,
                sortedCurrentMonthTransactions,
                sortedOtherTransactions
            ]
            
            presenter?.isTransactionDataFethed(data: separatedTransactions, error: nil)
            
        case .failure(let error):
            
            presenter?.isTransactionDataFethed(data: nil, error: error)
            
        }
    }
}
