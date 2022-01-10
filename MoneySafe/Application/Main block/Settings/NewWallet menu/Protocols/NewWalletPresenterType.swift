//
//  NewWalletPresenterType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 02.01.2022.
//

import Foundation

protocol NewWalletPresenterType {
    
    var view: NewWalletViewControllerType?  { get set }
    
    var interactor: NewWalletInteractorType? { get set }
    
    var router: NewWalletRouterType? { get set }
    
    func saveButtonPressed()
    
    func backButtonPressed()
    
}
