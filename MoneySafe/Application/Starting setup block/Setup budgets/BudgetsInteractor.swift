//
//  BudgetsInteractor.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 23.12.2021.
//

import Foundation
import UIKit

class BudgetsInteractor: BudgetsInteractorType {
    
    var presenter: BudgetsPresenterType?
    
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
    
    func saveSettings(incomeCategoriesID: [String],
                      expenseCaregoriesID: [String],
                      wallets: [GeneralWalletModel],
                      budgets: [GeneralBudgetModel]) {
        
        
        let coreDataManager = CoreDataManager.shared
        
        let userSettings = UserSettings()
        userSettings.incomeCategoriesID = incomeCategoriesID
        userSettings.expenseCategoriesID = expenseCaregoriesID
        
        for walletModel in wallets {
            
            let walletManagedObject = Wallet()
            walletManagedObject.isActive = true
            walletManagedObject.walletName = walletModel.walletName
            walletManagedObject.balance = NSDecimalNumber(decimal: walletModel.balance)
            walletManagedObject.user = userSettings
            userSettings.addToWallets(walletManagedObject)
            
        }
        
        for budgetModel in budgets {
            
            let budgetManagedObject = BudgetUnit()
            budgetManagedObject.categoryID = budgetModel.categoryID
            budgetManagedObject.budget = NSDecimalNumber(decimal: budgetModel.budget ?? 0)
            budgetManagedObject.user = userSettings
            userSettings.addToBudgetUnits(budgetManagedObject)
        }
        
        coreDataManager.saveContext()
        
        
        UserDefaults.standard.set(true, forKey: "startSetup")
    }
}
