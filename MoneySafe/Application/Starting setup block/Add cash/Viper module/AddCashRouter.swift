//
//  Router.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 19.12.2021.
//

import Foundation
import UIKit

class AddCashRouter: AddCashRouterType {
    
    var entryPoint: AddCashEntryPoint?
    
    static func start() -> AddCashRouterType      {
        
        let router = AddCashRouter()
    
        var view: AddCashViewControllerType = AddCashViewController()
        var interactor: AddCashInteractorType = AddCashInteractor()
        var presenter: AddCashPresenterType = AddCashPresenter()
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        view.presenter = presenter
        interactor.presenter = presenter
        
        router.entryPoint = view as? AddCashEntryPoint
        
        return router
    }
    
    func route(with wallet: GeneralWalletModel?)  {
        
        let nextStepRouter = AddWalletRouter.start(with: wallet)
        
        guard let nextEntryPoint = nextStepRouter.entryPoint else { return }
        entryPoint?.show(nextEntryPoint, sender: nil)
    }
    
    
}
