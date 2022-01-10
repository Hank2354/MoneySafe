//
//  BudgetsSettingsInteractor.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 01.01.2022.
//

import Foundation

class BudgetsSettingsInteractor: BudgetsSettingsInteractorType {
    
    var presenter: BudgetsSettingsPresenterType?
    
    var coreDataManager = CoreDataManager.shared
    
    func createCategories() {
        
        var currentCategories = [GeneralCategoryModel]()
        
        for category in expenseCaregories {
            
            let categoryID = category.categoryID
            let selectedCategoriesID = presenter?.expenseCategoriesID
            
            guard let selectedCategoriesID = selectedCategoriesID else { return }
            
            for selectedCategoryID in selectedCategoriesID {
                if categoryID == selectedCategoryID {
                    currentCategories.append(category)
                }
            }
        }
        
        presenter?.categoriesIsCreated(result: currentCategories)
    
}
    
    func getCurrentBudgets(budgetTextFields: [BudgetTextField]) -> [GeneralBudgetModel] {
        
        var budgets = [GeneralBudgetModel]()

        for textField in budgetTextFields {

            let moneyText = textField.text!

            let money: Decimal = Decimal(string: moneyText) ?? 0
            let budget = GeneralBudgetModel(categoryID: textField.categoryID, budget: money)

            budgets.append(budget)
        }
        
        return budgets
       
    }
    
    func saveSettings(budgets: [GeneralBudgetModel], expenseCategoriesID: [String]) {
        
        let userSettings = coreDataManager.getUserSettings()
        
        switch userSettings {
            
        case .success(let userSettings):
            
            userSettings.expenseCategoriesID = expenseCategoriesID
            
            let budgetUnits = userSettings.budgetUnits!
            userSettings.removeFromBudgetUnits(budgetUnits)
            
            for budgetModel in budgets {
                
                let budgetManagedObject = BudgetUnit()
                budgetManagedObject.categoryID = budgetModel.categoryID
                budgetManagedObject.user = userSettings
                
                if let currentBudget = budgetModel.budget {
                    budgetManagedObject.budget = currentBudget.round() as NSDecimalNumber
                } else {
                    budgetManagedObject.budget = 0
                }
                
                userSettings.addToBudgetUnits(budgetManagedObject)
                
            }
            
            coreDataManager.saveContext()
            
        case .failure(let error):
            
            print(error)
            return
        
        }
        
    }
    
    func getUserBudgets() -> Result<[GeneralBudgetModel], Errors> {
        
        let budgetUnits = coreDataManager.getUserBudgetUnits()
        
        switch budgetUnits {
            
        case .success(let budgetUnits):
            
            var result = [GeneralBudgetModel]()
           
            for budgetUnit in budgetUnits {
                
                guard let categoryID = budgetUnit.categoryID,
                      let budget = budgetUnit.budget else { return .failure(.loadUserBudgetsError) }
                
                result.append(GeneralBudgetModel(categoryID: categoryID,
                                                 budget: budget as Decimal))
                
            }
            
            return .success(result)
            
        case .failure(let error):
            
            return .failure(error)
        
        }
        
    }
    
}
