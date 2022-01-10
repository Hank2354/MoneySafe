//
//  AnalyticsRouter.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 30.12.2021.
//

import Foundation

class AnalyticsRouter: AnalyticsRouterType {
    
    var entryPoint: AnalyticsEntryPoint?
    
    static func start() -> AnalyticsRouterType {
        
        let router = AnalyticsRouter()
    
        var view: AnalyticsViewControllerType = AnalyticsViewController()
        var interactor: AnalyticsInteractorType = AnalyticsInteractor()
        var presenter: AnalyticsPresenterType = AnalyticsPresenter()
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        view.presenter = presenter
        interactor.presenter = presenter
        
        interactor.getCurrentMonthAndYear()
        
        router.entryPoint = view as? AnalyticsEntryPoint
        
        return router
    }
    
    func stop() {
        entryPoint?.navigationController?.popViewController(animated: true)
    }
    
    func route() {
        
    }
    
    
}
