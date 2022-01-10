//
//  BudgetsRouter.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 23.12.2021.
//

import Foundation
import UIKit

class BudgetsRouter: BudgetsRouterType {
    
    
    var entryPoint: BudgetsEntryPoint?
    
    static func start(with wallets: [GeneralWalletModel], incomeCategoriesID: [String], expenseCategoriesID: [String]) -> BudgetsRouterType {
        
        let router = BudgetsRouter()
    
        var view: BudgetsViewControllerType = BudgetsViewController()
        var interactor: BudgetsInteractorType = BudgetsInteractor()
        var presenter: BudgetsPresenterType = BudgetsPresenter()
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        presenter.wallets = wallets
        presenter.incomeCategoriesID = incomeCategoriesID
        presenter.expenseCategoriesID = expenseCategoriesID
        view.presenter = presenter
        interactor.presenter = presenter
        
        router.entryPoint = view as? BudgetsEntryPoint
        
        interactor.createCategories()
        
        return router
    }
    
    func stop() {
        entryPoint?.navigationController?.popViewController(animated: true)
    }
    
    func route() {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let appDelegate = appDelegate else { return }
        
        appDelegate.mainBlockStarting()
    }
    
    
}
