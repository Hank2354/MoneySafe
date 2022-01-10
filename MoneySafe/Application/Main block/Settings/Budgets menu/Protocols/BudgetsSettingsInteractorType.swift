//
//  BudgetsSettingsInteractorType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 01.01.2022.
//

import Foundation

protocol BudgetsSettingsInteractorType {
    
    var presenter: BudgetsSettingsPresenterType? { get set }
    
    func createCategories()
    
    func getCurrentBudgets(budgetTextFields: [BudgetTextField]) -> [GeneralBudgetModel]
    
    func saveSettings(budgets: [GeneralBudgetModel], expenseCategoriesID: [String])
    
    func getUserBudgets() -> Result<[GeneralBudgetModel], Errors>
}
