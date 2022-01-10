//
//  NewWalletRouter.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 02.01.2022.
//

import Foundation

class NewWalletRouter: NewWalletRouterType {
    
    var entryPoint: NewWalletEntryPoint?
    
    static func start() -> NewWalletRouterType {
        
        let router = NewWalletRouter()
    
        var view: NewWalletViewControllerType = NewWalletViewController()
        var interactor: NewWalletInteractorType = NewWalletInteractor()
        var presenter: NewWalletPresenterType = NewWalletPresenter()
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        view.presenter = presenter
        interactor.presenter = presenter
        
        router.entryPoint = view as? NewWalletEntryPoint
        
        return router
    }
    
    func stop() {
        entryPoint?.navigationController?.popViewController(animated: true)
    }
    
}
