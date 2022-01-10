//
//  BudgetsSettingsRouter.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 01.01.2022.
//

import Foundation

class BudgetsSettingsRouter: BudgetsSettingsRouterType {
    
    var entryPoint: BudgetsSettingsEntryPoint?
    
    static func start(with expenseCategoriesID: [String]) -> BudgetsSettingsRouterType {
        
        let router = BudgetsSettingsRouter()
    
        var view: BudgetsSettingsViewControllerType = BudgetsSettingsViewController()
        var interactor: BudgetsSettingsInteractorType = BudgetsSettingsInteractor()
        var presenter: BudgetsSettingsPresenterType = BudgetsSettingsPresenter()
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        presenter.expenseCategoriesID = expenseCategoriesID
        view.presenter = presenter
        interactor.presenter = presenter
        
        router.entryPoint = view as? BudgetsSettingsEntryPoint
        
        interactor.createCategories()
        
        return router
        
    }
    
    func stop() {
        entryPoint?.navigationController?.popViewController(animated: true)
    }
    
    func stopToMainSettingsScreen() {
        
        entryPoint?.navigationController?.popToRootViewController(animated: true)
    }
}
