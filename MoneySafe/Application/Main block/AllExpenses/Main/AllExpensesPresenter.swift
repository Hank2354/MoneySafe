//
//  AllExpensesPresenter.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 30.12.2021.
//

import Foundation

class AllExpensesPresenter: AllExpensesPresenterType {
    
    var view: AllExpensesTableViewControllerType?
    
    var interactor: AllExpensesInteractorType?
    
    var router: AllExpensesRouterType?
    
    func backButtonPressed() {
        router?.stop()
    }
    
    func isTransactionDataFethed(data: [[GeneralTransactionModel]]?, error: Errors?) {
        
        guard let data = data,
              error == nil else {
            
            switch error! {
            case .loadWalletsError:
                view?.presentWarnMessage(title: "Ошибка базы данных", message: "Произошла ошибка при загрузке кошельков")
            case .loadUserSettingsError:
                view?.presentWarnMessage(title: "Ошибка базы данных", message: "Произошла ошибка при загрузке настроек")
            case .loadUserBudgetsError:
                view?.presentWarnMessage(title: "Ошибка базы данных", message: "Произошла ошибка при загрузке бюджетов")
            case .loadTransactionsError:
                view?.presentWarnMessage(title: "Ошибка базы данных", message: "Произошла ошибка при загрузке транзакций")
            default:
                return
            }
            
            return
            
        }
        
        view?.update(with: data)
        
        
        
        
        
    }
    
    func transactionTapped(model: GeneralTransactionModel) {
        router?.route(transaction: model.transactionMO)
    }
    
    func updateData() {
        interactor?.getTransactionData()
    }
}
