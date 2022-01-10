//
//  NewExpenseRouter.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 27.12.2021.
//

import Foundation

class NewExpenseRouter: NewExpenseRouterType {
    
    var entryPoint: NewExpenseEntryPoint?
    
    static func start() -> NewExpenseRouterType {
        
        let router = NewExpenseRouter()
    
        var view: NewExpenseViewControllerType = NewExpenseViewController()
        var interactor: NewExpenseInteractorType = NewExpenseInteractor()
        var presenter: NewExpensePresenterType = NewExpensePresenter()
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        view.presenter = presenter
        interactor.presenter = presenter
        
        router.entryPoint = view as? NewExpenseEntryPoint
        
        interactor.fetchUserData()
        
        return router
    }
    
    
    func stop() {
        entryPoint?.dismiss(animated: true, completion: nil)
    }
    
    
}
