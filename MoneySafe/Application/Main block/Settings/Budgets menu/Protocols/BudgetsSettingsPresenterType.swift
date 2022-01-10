//
//  BudgetsSettingsPresenterType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 01.01.2022.
//

import Foundation

protocol BudgetsSettingsPresenterType {
    
    var view: BudgetsSettingsViewControllerType? { get set }
    
    var interactor: BudgetsSettingsInteractorType? { get set }
    
    var router: BudgetsSettingsRouterType? { get set }
    
    var expenseCategoriesID: [String] { get set }
    
    func categoriesIsCreated(result: [GeneralCategoryModel])
    
    func isContinueButtonPressed()
    
    func isBackButtonPressed()
    
    func isDoneButtonPressed()
    
    func updateTextFieldValues()
}
