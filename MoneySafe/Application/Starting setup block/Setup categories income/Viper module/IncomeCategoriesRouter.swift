//
//  IncomeCategoriesRouter.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 21.12.2021.
//

import Foundation

class IncomeCategoriesRouter: IncomeCategoriesRouterType {
    
    var entryPoint: IncomeCategoriesEntryPoint?
    
    static func start(with wallets: [GeneralWalletModel]) -> IncomeCategoriesRouterType {
        
        let router = IncomeCategoriesRouter()
    
        var view: IncomeCategoriesViewControllerType = IncomeCategoriesViewController()
        var interactor: IncomeCategoriesInteractorType = IncomeCategoriesInteractor()
        var presenter: IncomeCategoriesPresenterType = IncomeCategoriesPresenter()
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        presenter.wallets = wallets
        view.presenter = presenter
        interactor.presenter = presenter
        
        router.entryPoint = view as? IncomeCategoriesEntryPoint
        
        interactor.createCaregories()
        
        return router
    }
    
    func stop() {
        entryPoint?.navigationController?.popViewController(animated: true)
    }
    
    func route(with wallets: [GeneralWalletModel], incomeCategoriesID: [String]) {
        
        let nextStepRouter = ExpenseCategoriesRouter.start(with: wallets, incomeCategoriesID: incomeCategoriesID)
        
        guard let nextEntryPoint = nextStepRouter.entryPoint else { return }
        entryPoint?.show(nextEntryPoint, sender: nil)
    }
    
    
}
