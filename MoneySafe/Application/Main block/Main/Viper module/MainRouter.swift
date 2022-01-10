//
//  MainRouter.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 27.12.2021.
//

import Foundation

class MainRouter: MainRouterType {
    
    var entryPoint: MainEntryPoint?
    
    static func start() -> MainRouterType {
        
        let router = MainRouter()
    
        var view: MainViewControllerType = MainViewController()
        var interactor: MainInteractorType = MainInteractor()
        var presenter: MainPresenterType = MainPresenter()
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        view.presenter = presenter
        interactor.presenter = presenter
        
        router.entryPoint = view as? MainEntryPoint
        
        return router
    }
    
    func route(to screen: ScreenType) {
        
        switch screen {
            
        case .newExpense:
            
            let nextStepRouter = NewExpenseRouter.start()
            
            guard let nextStepRouter = nextStepRouter.entryPoint else { return }
            entryPoint?.present(nextStepRouter, animated: true, completion: nil)
            
        case .newIncome:
            
            let nextStepRouter = NewIncomeRouter.start()
            
            guard let nextStepRouter = nextStepRouter.entryPoint else { return }
            entryPoint?.present(nextStepRouter, animated: true, completion: nil)
            
        case .analytics:
            
            let nextStepRouter = AnalyticsRouter.start()
            
            guard let nextStepRouter = nextStepRouter.entryPoint else { return }
            entryPoint?.show(nextStepRouter, sender: nil)
            
        case .allExpenses:
            
            let nextStepRouter = AllExpensesRouter.start()
            
            guard let nextStepRouter = nextStepRouter.entryPoint else { return }
            entryPoint?.show(nextStepRouter, sender: nil)
            
        case .settings:
            
            let nextStepRouter = SettingsRouter.start()
            
            guard let nextStepRouter = nextStepRouter.entryPoint else { return }
            entryPoint?.show(nextStepRouter, sender: nil)
            
        }
        

        
    }
    
    
}
