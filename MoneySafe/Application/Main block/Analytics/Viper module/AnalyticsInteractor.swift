//
//  AnalyticsInteractor.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 30.12.2021.
//

import Foundation

class AnalyticsInteractor: AnalyticsInteractorType {
    
    var presenter: AnalyticsPresenterType?
    
    var coreDataManager = CoreDataManager.shared
    var dateManager = DateManager.shared
    
    func getCurrentMonthAndYear() {
        let currentMonth = dateManager.getMonthString(Date())
        let currentYear = dateManager.getYearString(Date())
        
        presenter?.currentMonthAndYearFethed(month: currentMonth, year: currentYear)
    }
    
    func getAnalyticsData(month: String, year: String, type: CategoryType) {
        
        // get all transactions
        let allTransaction = coreDataManager.getAllTransactions()
        
        switch allTransaction {
            
        case .success(let allTransactions):
            
            // save all transaction with selected type in array, also save expense and income transaction in current month
            var currentMonthTransactions = [Transaction]()
            var currentMonthExpenseTransactions = [Transaction]()
            var currentMonthIncomeTransactions = [Transaction]()
            
            for transaction in allTransactions {
                
                let transactionMonth = dateManager.getMonthString(transaction.date)
                let transactionYear = dateManager.getYearString(transaction.date)
                
                guard let transactionCategoryID = transaction.categoryID else {
                    
                    presenter?.analyticsDataIsFethed(pieData: nil, barData: nil, budgetModel: nil, error: .loadTransactionsError)
                    
                    return
                }
                
                if transactionMonth == month, transactionYear == year, transactionCategoryID.isExpenseCategoryID() {
                    
                    currentMonthExpenseTransactions.append(transaction)
                    
                }
                
                if transactionMonth == month, transactionYear == year, !transactionCategoryID.isExpenseCategoryID() {
                    
                    currentMonthIncomeTransactions.append(transaction)
                    
                }
                
                switch type {
                case .income:
                    
                    if transactionMonth == month, transactionYear == year, !transactionCategoryID.isExpenseCategoryID() {
                        
                        currentMonthTransactions.append(transaction)
                        
                    }
                    
                case .expense:
                    
                    if transactionMonth == month, transactionYear == year, transactionCategoryID.isExpenseCategoryID() {
                        
                        currentMonthTransactions.append(transaction)
                        
                    }
                    
                }
                
            }
            
            // Now we have all transaction, also all expense and income transactions
            
            // get all categoryID from transactions
            
            var categoriesID = [String]()
            
            for transaction in currentMonthTransactions {
                
                guard let transactionCategoryID = transaction.categoryID else {
                    
                    presenter?.analyticsDataIsFethed(pieData: nil, barData: nil, budgetModel: nil, error: .loadTransactionsError)
                    
                    return
                }
                
                categoriesID.append(transactionCategoryID)
                
            }
            
            // delete equal elements
            
            let categoriesIDWithoutRepeatingElements = Array(Set(categoriesID))
            
            // now create analytics data models in cycle
            
            var analyticsDataModels = [MainAnalyticsDataModel]()
            
            for caregoryID in categoriesIDWithoutRepeatingElements {
                
                // totalExpenses for selected category
                
                var totalExpenses: Decimal = 0
                
                // calculate amount for all transaction with selected categoryID
                for transaction in currentMonthTransactions where transaction.categoryID! == caregoryID {
                    
                    totalExpenses += transaction.amount! as Decimal
                    
                }
                
                // and get current category by ID
                let currentCategory = getCategoryFromID(id: caregoryID)
                
                guard let currentCategory = currentCategory else {
                    
                    presenter?.analyticsDataIsFethed(pieData: nil, barData: nil, budgetModel: nil, error: .loadUserSettingsError)
                    
                    return
                    
                }

                // create dataModel and append it in main dataModels array
                analyticsDataModels.append(MainAnalyticsDataModel(category: currentCategory, amount: totalExpenses))
                
            }
            
            // save all expenses or incomes
            var totalExpensesOrIncomes: Decimal = 0
            
            for dataModel in analyticsDataModels {
                totalExpensesOrIncomes += dataModel.amount
            }
            
            // get all expenses and budgets
            
            let userBudgets = coreDataManager.getUserBudgetUnits()
            
            switch userBudgets {
                
            case .success(let userBudgets):
                
                // get total budget
                
                var totalBudget: Decimal = 0
                
                for budget in userBudgets {
                    
                    totalBudget += budget.budget! as Decimal
                    
                }
                
                // get total expenses
                var totalExpenses: Decimal = 0
                
                for transaction in currentMonthExpenseTransactions {
                    totalExpenses += transaction.amount! as Decimal
                }
                
                // get total incomes
                var totalIncomes: Decimal = 0
                
                for transaction in currentMonthIncomeTransactions {
                    totalIncomes += transaction.amount! as Decimal
                }
                
                presenter?.analyticsDataIsFethed(pieData: GeneralMainAnalyticsModel(month: month,
                                                                                   year: year,
                                                                                   totalExpensesBalance: totalExpensesOrIncomes,
                                                                                   data: analyticsDataModels),
                                                 
                                                 barData: GeneralBarAnalyticsModel(totalExpenses: totalExpenses,
                                                                                   totalIncomes: totalIncomes),
                                                 
                                                 budgetModel: GeneralActualBudgetModel(category: nil,
                                                                                       budget: totalBudget,
                                                                                       totalExpenses: totalExpenses),
                                                 error: nil)
                
            case .failure(let error):
                
                presenter?.analyticsDataIsFethed(pieData: nil, barData: nil, budgetModel: nil, error: error)
                
            }
            
        case .failure(let error):
            presenter?.analyticsDataIsFethed(pieData: nil, barData: nil, budgetModel: nil, error: error)
        }
        
    }
    
}
