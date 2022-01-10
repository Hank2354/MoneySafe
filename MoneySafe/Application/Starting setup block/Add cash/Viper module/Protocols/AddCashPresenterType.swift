//
//  AddCashPresenterType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 19.12.2021.
//

import Foundation

protocol AddCashPresenterType {
    
    var interactor: AddCashInteractorType? { get set }
    
    var router: AddCashRouterType? { get set }
    
    var view: AddCashViewControllerType? { get set }
    
    func isContinueButtonPressed()
    
    func isSkipButtonPressed()
}
