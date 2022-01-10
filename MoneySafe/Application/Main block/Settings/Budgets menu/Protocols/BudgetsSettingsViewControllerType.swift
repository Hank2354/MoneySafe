//
//  BudgetsSettingsViewControllerType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 01.01.2022.
//

import Foundation

protocol BudgetsSettingsViewControllerType {
    
    var presenter: BudgetsSettingsPresenterType? { get set }
    
    var categoryViews: [CategoryView] { get set }
    
    var budgetTextFields: [BudgetTextField] { get set }
    
    func update(with categories: [GeneralCategoryModel])
    
    func saveSettings()
    
    func backAction()
}
