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
        
        // Получаем все транзакции
        let allTransaction = coreDataManager.getAllTransactions()
        
        switch allTransaction {
            
        case .success(let allTransactions):
            
            // Сохраняем все транзакции с выбранным типом в массив и все транзакции по расходам, а так же все транзакции по доходам
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
            
            // На данном этапе у нас есть массив транзакций в текущем месяце и массив транзакций с расходами, а так же массив с доходами
            
            // Получаем массив, айдишников категорий, которые были использованы в текущем месяце
            
            var categoriesID = [String]()
            
            for transaction in currentMonthTransactions {
                
                guard let transactionCategoryID = transaction.categoryID else {
                    
                    presenter?.analyticsDataIsFethed(pieData: nil, barData: nil, budgetModel: nil, error: .loadTransactionsError)
                    
                    return
                }
                
                categoriesID.append(transactionCategoryID)
                
            }
            
            // Теперь убираем повторяющиеся элементы в массиве айдишников
            
            let categoriesIDWithoutRepeatingElements = Array(Set(categoriesID))
            
            // Теперь проходимся по новому массиву айдишников, и собираем данные в модель
            
            var analyticsDataModels = [MainAnalyticsDataModel]()
            
            for caregoryID in categoriesIDWithoutRepeatingElements {
                
                // создаем переменную общего расхода по категории
                
                var totalExpenses: Decimal = 0
                
                // Проходимся по массиву транзакций месяца, сохраняем расходы у всех транзакций с текущим айди категории
                for transaction in currentMonthTransactions where transaction.categoryID! == caregoryID {
                    
                    totalExpenses += transaction.amount! as Decimal
                    
                }
                
                // получаем текущую категорию по айди
                let currentCategory = getCategoryFromID(id: caregoryID)
                
                guard let currentCategory = currentCategory else {
                    
                    presenter?.analyticsDataIsFethed(pieData: nil, barData: nil, budgetModel: nil, error: .loadUserSettingsError)
                    
                    return
                    
                }

                // создаем модель данных и добавляем ее в общий массив
                analyticsDataModels.append(MainAnalyticsDataModel(category: currentCategory, amount: totalExpenses))
                
            }
            
            // Сохраняем общие расходы/доходы за месяц в переменную
            var totalExpensesOrIncomes: Decimal = 0
            
            for dataModel in analyticsDataModels {
                totalExpensesOrIncomes += dataModel.amount
            }
            
            // Теперь получаем данные по всем расходам и бюджетам
            
            let userBudgets = coreDataManager.getUserBudgetUnits()
            
            switch userBudgets {
                
            case .success(let userBudgets):
                
                // Складываем все бюджеты для получения общего бюджета
                
                var totalBudget: Decimal = 0
                
                for budget in userBudgets {
                    
                    totalBudget += budget.budget! as Decimal
                    
                }
                
                // Получаем все расходы за месяц
                var totalExpenses: Decimal = 0
                
                for transaction in currentMonthExpenseTransactions {
                    totalExpenses += transaction.amount! as Decimal
                }
                
                // Получаем все доходы за месяц
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
