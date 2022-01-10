//
//  CategoriesSettingsRouter.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 01.01.2022.
//

import Foundation

class CategoriesSettingsRouter: CategoriesSettingsRouterType {
    
    var entryPoint: CategoriesSettingsEntryPoint?
    
    static func start(categoryType: CategoryType) -> CategoriesSettingsRouterType {
        
        let router = CategoriesSettingsRouter()
    
        var view: CategoriesSettingsViewControllerType = CategoriesSettingsViewController()
        var interactor: CategoriesSettingsInteractorType = CategoriesSettingsInteractor()
        var presenter: CategoriesSettingsPresenterType = CategoriesSettingsPresenter()
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        view.presenter = presenter
        interactor.presenter = presenter
        
        interactor.categoryType = categoryType
        interactor.createCaregories()
        
        router.entryPoint = view as? CategoriesSettingsEntryPoint
        
        return router
        
    }
    
    func stop() {
        entryPoint?.navigationController?.popViewController(animated: true)
    }
    
    func route(with expenseCategories: [String]) {
        
        let nextStepRouter = BudgetsSettingsRouter.start(with: expenseCategories)
        
        guard let nextEntryPoint = nextStepRouter.entryPoint else { return }
        entryPoint?.show(nextEntryPoint, sender: nil)
        
    }
}
