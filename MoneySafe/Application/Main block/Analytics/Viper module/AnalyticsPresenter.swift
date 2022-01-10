//
//  AnalyticsPresenter.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 30.12.2021.
//

import Foundation
import UIKit

class AnalyticsPresenter: AnalyticsPresenterType {
    
    var view: AnalyticsViewControllerType?
    
    var interactor: AnalyticsInteractorType?
    
    var router: AnalyticsRouterType?
    
    func currentMonthAndYearFethed(month: String, year: String) {
        view?.currentYear = year
        view?.currentMonth = month
    }
    
    func analyticsDataIsFethed(pieData: GeneralMainAnalyticsModel?,
                               barData: GeneralBarAnalyticsModel?,
                               budgetModel: GeneralActualBudgetModel?,
                               error: Errors?) {
        
        guard let pieData = pieData,
              let budgetModel = budgetModel,
              let barData = barData,
              error == nil else {
            
            let title = "Ошибка"
            
            var message = ""
            
            switch error! {
                
            case .loadUserSettingsError:
                message = "Ошибка загрузки пользовательских настроек"
            case .loadTransactionsError:
                message = "Ошибка загрузки транзакций"
            case .loadWalletsError:
                message = "Ошибка загрузки кошельков"
            default:
                message = "Неизвестная ошибка"
                
            }
            
            let ac = createAlertController(title: title, message: message)
            
            view?.presentWarnMessage(alertController: ac)
            
            return
        }

        view?.update(with: pieData, barData: barData, totalBudget: budgetModel.budget, totalExpensesMonth: budgetModel.totalExpenses)
        
    }
    
    func backButtonPressed() {
        router?.stop()
    }
    
    func createAlertController(title: String?, message: String?) -> UIAlertController {
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        ac.addAction(okButton)
        
        return ac
        
    }
    
    func updateCharts(type: CategoryType) {
        let month = view?.currentMonth
        let year = view?.currentYear
        
        interactor?.getAnalyticsData(month: month!, year: year!, type: type)
    }
    
}
