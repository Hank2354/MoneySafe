//
//  AboutExpenseRouter.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 01.01.2022.
//

import Foundation

class AboutExpenseRouter: AboutExpenseRouterType {
    
    var entryPoint: AboutExpenseEntryPoint?
    
    static func start(with transaction: Transaction) -> AboutExpenseRouterType {
        
        let router = AboutExpenseRouter()
    
        var view: AboutExpenseViewControllerType = AboutExpenseViewController()
        var interactor: AboutExpenseInteractorType = AboutExpenseInteractor()
        var presenter: AboutExpensePresenterType = AboutExpensePresenter()
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        view.presenter = presenter
        interactor.presenter = presenter
        
        interactor.selectedTransaction = transaction
        
        interactor.fetchUserData()
        
        router.entryPoint = view as? AboutExpenseEntryPoint
        
        return router
        
    }
    
    func stop() {
        entryPoint?.navigationController?.popViewController(animated: true)
    }
    
}
