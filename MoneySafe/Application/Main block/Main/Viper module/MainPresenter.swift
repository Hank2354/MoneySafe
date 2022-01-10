//
//  MainPresenter.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 27.12.2021.
//

import Foundation
import UIKit

class MainPresenter: MainPresenterType {
    
    var view: MainViewControllerType?
    
    var interactor: MainInteractorType?
    
    var router: MainRouterType?
    
    func functionButtonPressed(_ button: UIButton) {
        
        switch button.tag {
        case 1:
            router?.route(to: .newIncome)
        case 2:
            router?.route(to: .newExpense)
        case 3:
            router?.route(to: .analytics)
        case 4:
            router?.route(to: .allExpenses)
        case 5:
            router?.route(to: .settings)
        default:
            return
        }
        
    }
    
    func userDataIsFetched(totalBalance: Decimal?,
                           budgetsWithTransactions: [GeneralActualBudgetModel]?,
                           currentMonth: String?,
                           error: Errors?) {
        
        guard let totalBalance = totalBalance,
              let budgetsWithTransactions = budgetsWithTransactions,
              let currentMonth = currentMonth,
              error == nil else {
                  
                  switch error {
                  case .loadTransactionsError:
                      
                      view?.presentWarnMessage(title: "Возникла ошибка базы данных",
                                               descriptionText: "Возникла ошибка при извлечении транзакций")
                      
                  case .loadWalletsError:
                      
                      view?.presentWarnMessage(title: "Возникла ошибка базы данных",
                                               descriptionText: "Возникла ошибка при извлечении кошельков")
                      
                  case .loadUserBudgetsError:
                      
                      view?.presentWarnMessage(title: "Возникла ошибка базы данных",
                                               descriptionText: "Возникла ошибка при извлечении бюджетов")
                      
                  case .loadUserSettingsError:
                      
                      view?.presentWarnMessage(title: "Возникла ошибка базы данных",
                                               descriptionText: "Возникла ошибка при извлечении пользовательских настроек")
                      
                  case .none:
                      
                      
                      view?.presentWarnMessage(title: "Возникла ошибка базы данных",
                                               descriptionText: "Неизвестная ошибка")
                      
                  default:
                      return
                      
                  }
                  
                  return
                  
        }

        
        DispatchQueue.main.async { [unowned self] in
            self.view?.update(with: totalBalance)
            self.view?.update(with: currentMonth)
        }
        
        let sortedArray = budgetsWithTransactions.sorted {
                
                
            let currentBalanceForFirstElement = $0.totalExpenses * 100 / $0.budget
            let currentBalanceForSecondElement = $1.totalExpenses * 100 / $1.budget
                
            return currentBalanceForFirstElement > currentBalanceForSecondElement
        }
        
        DispatchQueue.main.async { [unowned self] in
            
            self.view?.update(with: sortedArray)
            
        }
    }
    
    func updateData() {
        interactor?.fetchUserData()
    }
    
    
}
