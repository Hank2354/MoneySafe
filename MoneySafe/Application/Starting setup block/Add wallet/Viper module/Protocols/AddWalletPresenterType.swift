//
//  AddWalletPresenterType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 19.12.2021.
//

import Foundation

protocol AddWalletPresenterType {
    
    var interactor: AddWalletInteractorType? { get set }
    
    var router: AddWalletRouterType? { get set }
    
    var view: AddWalletViewControllerType? { get set }
    
    var cashWallet: GeneralWalletModel? { get set }
    
    func isContinueButtonPressed()
    
    func isSkipButtonPressed()
    
    func isBackButtonPressed()
}
