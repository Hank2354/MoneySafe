//
//  NewIncomeRouter.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 27.12.2021.
//

import Foundation

class NewIncomeRouter: NewIncomeRouterType {
    
    var entryPoint: NewIncomeEntryPoint?
    
    static func start() -> NewIncomeRouterType {
        
        let router = NewIncomeRouter()
    
        var view: NewIncomeViewControllerType = NewIncomeViewController()
        var interactor: NewIncomeInteractorType = NewIncomeInteractor()
        var presenter: NewIncomePresenterType = NewIncomePresenter()
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        view.presenter = presenter
        interactor.presenter = presenter
        
        router.entryPoint = view as? NewIncomeEntryPoint
        
        interactor.fetchUserData()
        
        return router
    }
    
    func stop() {
        entryPoint?.dismiss(animated: true, completion: nil)
    }
    
    
}
