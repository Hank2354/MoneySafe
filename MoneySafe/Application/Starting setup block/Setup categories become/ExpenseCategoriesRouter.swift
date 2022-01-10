//
//  ExpenseCategoriesRouter.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 23.12.2021.
//

import Foundation

class ExpenseCategoriesRouter: ExpenseCategoriesRouterType {
    
    
    var entryPoint: ExpenseCategoriesEntryPoint?
    
    static func start(with wallets: [GeneralWalletModel], incomeCategoriesID: [String]) -> ExpenseCategoriesRouterType {
        
        let router = ExpenseCategoriesRouter()
    
        var view: ExpenseCategoriesViewControllerType = ExpenseCategoriesViewController()
        var interactor: ExpenseCategoriesInteractorType = ExpenseCategoriesInteractor()
        var presenter: ExpenseCategoriesPresenterType = ExpenseCategoriesPresenter()
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        presenter.wallets = wallets
        presenter.incomeCategoriesID = incomeCategoriesID
        view.presenter = presenter
        interactor.presenter = presenter
        
        router.entryPoint = view as? ExpenseCategoriesEntryPoint
        
        interactor.createCaregories()
        
        return router
    }
    
    func stop() {
        entryPoint?.navigationController?.popViewController(animated: true)
    }
    
    func route(with wallets: [GeneralWalletModel], incomeCategoriesID: [String], expenseCategoriesID: [String]) {
        
        let nextStepRouter = BudgetsRouter.start(with: wallets, incomeCategoriesID: incomeCategoriesID, expenseCategoriesID: expenseCategoriesID)
        
        guard let nextEntryPoint = nextStepRouter.entryPoint else { return }
        entryPoint?.show(nextEntryPoint, sender: nil)
        
    }
    
    
}
