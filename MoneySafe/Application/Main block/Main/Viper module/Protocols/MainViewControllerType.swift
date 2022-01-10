//
//  MainViewControllerType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 27.12.2021.
//

import Foundation

protocol MainViewControllerType {
    
    var presenter: MainPresenterType? { get set }
    
    var currentBudgetViews: [BudgetView] { get set }
    
    func update(with totalBalance: Decimal)
    
    func update(with actualBudgetModels: [GeneralActualBudgetModel])
    
    func update(with mouth: String)
    
    func presentWarnMessage(title: String?, descriptionText: String?)
    
}
