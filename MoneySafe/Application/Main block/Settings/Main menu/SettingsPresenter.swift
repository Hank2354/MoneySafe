//
//  SettingsPresenter.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 30.12.2021.
//

import Foundation

class SettingsPresenter: SettingsPresenterType {
    
    var view: SettingsViewControllerType?
    
    var interactor: SettingsInteractorType?
    
    var router: SettingsRouterType?
    
    func backButtonPressed() {
        router?.stop()
    }
    
    func myWalletsButtonPressed() {
        router?.route(to: .walletSettings)
    }
    
    func myIncomeCaregoriesButtonPressed() {
        router?.route(to: .incomeCategoriesSettings)
    }
    
    func myExpenseCaregoriesButtonPressed() {
        router?.route(to: .expenseCategoriesSettings)
    }
    
    
}
