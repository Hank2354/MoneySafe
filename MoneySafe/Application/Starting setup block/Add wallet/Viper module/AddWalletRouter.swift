//
//  AddWalletRouter.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 19.12.2021.
//

import Foundation
import UIKit

class AddWalletRouter: AddWalletRouterType {
    
    var entryPoint: AddWalletEntryPoint?
    
    static func start(with wallet: GeneralWalletModel?) -> AddWalletRouterType {
        
        let router = AddWalletRouter()
    
        var view: AddWalletViewControllerType = AddWalletViewController()
        var interactor: AddWalletInteractorType = AddWalletInteractor()
        var presenter: AddWalletPresenterType = AddWalletPresenter()
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        presenter.cashWallet = wallet
        view.presenter = presenter
        interactor.presenter = presenter
        
        router.entryPoint = view as? AddWalletEntryPoint
        
        return router
    }
    
    func stop() {
        entryPoint?.navigationController?.popViewController(animated: true)
    }
    
    func route(with wallets: [GeneralWalletModel]) {
        let nextStepRouter = IncomeCategoriesRouter.start(with: wallets)
        
        guard let nextEntryPoint = nextStepRouter.entryPoint else { return }
        entryPoint?.show(nextEntryPoint, sender: nil)
    }
    
}
