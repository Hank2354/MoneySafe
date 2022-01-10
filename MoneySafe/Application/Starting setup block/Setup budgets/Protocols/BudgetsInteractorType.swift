//
//  BudgetsInteractorType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 23.12.2021.
//

import Foundation

protocol BudgetsInteractorType {
    
    var presenter: BudgetsPresenterType? { get set }
    
    func createCategories()
    
    func getCurrentBudgets(budgetTextFields: [BudgetTextField]) -> [GeneralBudgetModel]
    
    func saveSettings(incomeCategoriesID: [String],
                      expenseCaregoriesID: [String],
                      wallets: [GeneralWalletModel],
                      budgets: [GeneralBudgetModel])
}
