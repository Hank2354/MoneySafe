//
//  AllExpensesRouter.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 30.12.2021.
//

import Foundation

class AllExpensesRouter: AllExpensesRouterType {
    
    var entryPoint: AllExpensesEntryPoint?
    
    static func start() -> AllExpensesRouterType {
        
        let router = AllExpensesRouter()
    
        var view: AllExpensesTableViewControllerType = AllExpensesTableViewController()
        var interactor: AllExpensesInteractorType = AllExpensesInteractor()
        var presenter: AllExpensesPresenterType = AllExpensesPresenter()
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        view.presenter = presenter
        interactor.presenter = presenter
        
        interactor.getTransactionData()
        
        router.entryPoint = view as? AllExpensesEntryPoint
        
        return router
    }
    
    func stop() {
        entryPoint?.navigationController?.popViewController(animated: true)
    }
    
    func route(transaction: Transaction) {
        
        let nextStepRouter = AboutExpenseRouter.start(with: transaction)
        
        guard let nextEntryPoint = nextStepRouter.entryPoint else { return }
        
        entryPoint?.show(nextEntryPoint, sender: nil)
    }
    
    
}
