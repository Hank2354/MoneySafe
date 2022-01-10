//
//  WalletsSettingsRouter.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 01.01.2022.
//

import Foundation

class WalletsSettingsRouter: WalletsSettingsRouterType {
    
    var entryPoint: WalletsSettingsEntryPoint?
    
    static func start() -> WalletsSettingsRouterType {
        
        let router = WalletsSettingsRouter()
    
        var view: WalletsSettingsViewControllerType = WalletsSettingsViewController()
        var interactor: WalletsSettingsInteractorType = WalletsSettingsInteractor()
        var presenter: WalletsSettingsPresenterType = WalletsSettingsPresenter()
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        view.presenter = presenter
        interactor.presenter = presenter
        
        interactor.fetchUserWalletsWithCurrentBalance()
        
        router.entryPoint = view as? WalletsSettingsEntryPoint
        
        return router
        
    }
    
    func stop() {
        entryPoint?.navigationController?.popViewController(animated: true)
    }
    
    func route() {
        
        let nextStepRouter = NewWalletRouter.start()
        
        guard let nextStepRouter = nextStepRouter.entryPoint else { return }
        entryPoint?.show(nextStepRouter, sender: nil)
        
    }
}
