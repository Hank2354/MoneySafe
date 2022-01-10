//
//  SettingsPresenterType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 30.12.2021.
//

import Foundation

protocol SettingsPresenterType {
    
    var view: SettingsViewControllerType? { get set }
    
    var interactor: SettingsInteractorType? { get set }
    
    var router: SettingsRouterType? { get set }
    
    func backButtonPressed()
    
    func myWalletsButtonPressed()
    
    func myIncomeCaregoriesButtonPressed()
    
    func myExpenseCaregoriesButtonPressed()
    
}
