//
//  BudgetsSettingsPresenter.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 01.01.2022.
//

import Foundation
import UIKit

class BudgetsSettingsPresenter: BudgetsSettingsPresenterType {
    
    var view: BudgetsSettingsViewControllerType?
    
    var interactor: BudgetsSettingsInteractorType?
    
    var router: BudgetsSettingsRouterType?
    
    var expenseCategoriesID = [String]()
    
    func categoriesIsCreated(result: [GeneralCategoryModel]) {
        view?.update(with: result)
    }
    
    func isContinueButtonPressed() {
        
        guard let budgetTextFields = view?.budgetTextFields else { return }
        
        let budgets = interactor?.getCurrentBudgets(budgetTextFields: budgetTextFields)
        
        guard let budgets = budgets else { return }
        
        interactor?.saveSettings(budgets: budgets, expenseCategoriesID: expenseCategoriesID)
        
        router?.stopToMainSettingsScreen()
    }
    
    func isBackButtonPressed() {
        router?.stop()
    }
    
    func isDoneButtonPressed() {
        
        let budgetTextFields = view?.budgetTextFields ?? []
        
        var currentTextField: UITextField!
        var nextTextField: UITextField?
        
        for budgetTextField in budgetTextFields {
            if budgetTextField.isFirstResponder {
                currentTextField = budgetTextField
            }
        }
        
        if currentTextField.tag < budgetTextFields.count {
            nextTextField = budgetTextFields[currentTextField.tag]
        }
        
        if let nextTextField = nextTextField {
            nextTextField.becomeFirstResponder()
        } else {
            currentTextField.resignFirstResponder()
        }
    }
    
    func updateTextFieldValues() {
        
        let userBudgets = interactor?.getUserBudgets()
        
        switch userBudgets {
            
        case .success(let userBudgets):
            
            for budgetTF in view?.budgetTextFields ?? [] {
                
                let currentID = budgetTF.categoryID
                
                for userBudget in userBudgets {
                    
                    if userBudget.categoryID == currentID {
                        
                        if let userBudgetBudget = userBudget.budget, userBudgetBudget != 0 {
                            
                            budgetTF.text = "\(userBudgetBudget)".applyMoneyStylePattern()
                            
                        }
                        
                    }
                    
                }
                
            }
            
        case .failure(let error):
            
            print(error)
            return
            
        case .none:
            
            return
            
        }
        
    }
    
}
