//
//  SettingsRouter.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 30.12.2021.
//

import Foundation

class SettingsRouter: SettingsRouterType {
    
    var entryPoint: SettingsEntryPoint?
    
    static func start() -> SettingsRouterType {
        
        let router = SettingsRouter()
    
        var view: SettingsViewControllerType = SettingsViewController()
        var interactor: SettingsInteractorType = SettingsInteractor()
        var presenter: SettingsPresenterType = SettingsPresenter()
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        view.presenter = presenter
        interactor.presenter = presenter
        
        router.entryPoint = view as? SettingsEntryPoint
        
        return router
    }
    
    func stop() {
        entryPoint?.navigationController?.popViewController(animated: true)
    }
    
    func route(to screenType: SettingsScreenType) {
        
        switch screenType {
            
        case .walletSettings:
            
            let nextStepRouter = WalletsSettingsRouter.start()
            
            guard let nextStepRouter = nextStepRouter.entryPoint else { return }
            entryPoint?.show(nextStepRouter, sender: nil)
            
        case .incomeCategoriesSettings:
            
            let nextStepRouter = CategoriesSettingsRouter.start(categoryType: .income)
            
            guard let nextStepRouter = nextStepRouter.entryPoint else { return }
            entryPoint?.show(nextStepRouter, sender: nil)
            
        case .expenseCategoriesSettings:
            
            let nextStepRouter = CategoriesSettingsRouter.start(categoryType: .expense)
            
            guard let nextStepRouter = nextStepRouter.entryPoint else { return }
            entryPoint?.show(nextStepRouter, sender: nil)
            
        case .budgetSettings:
            return
        
        }
    
    }
    
}
