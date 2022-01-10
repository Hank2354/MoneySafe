//
//  BudgetsPresenter.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 23.12.2021.
//

import Foundation
import UIKit

class BudgetsPresenter: BudgetsPresenterType {
    
    var interactor: BudgetsInteractorType?
    
    var router: BudgetsRouterType?
    
    var view: BudgetsViewControllerType?
    
    var wallets = [GeneralWalletModel]()
    
    var incomeCategoriesID = [String]()
    
    var expenseCategoriesID = [String]()
        
    func categoriesIsCreated(result: [GeneralCategoryModel]) {
        view?.update(with: result)
    }
    
    func isContinueButtonPressed() {
        
        guard let budgetTextFields = view?.budgetTextFields else { return }
        
        let budgets = interactor?.getCurrentBudgets(budgetTextFields: budgetTextFields)
        
        guard let budgets = budgets else { return }
        
        interactor?.saveSettings(incomeCategoriesID: incomeCategoriesID,
                                 expenseCaregoriesID: expenseCategoriesID,
                                 wallets: wallets,
                                 budgets: budgets)
        
        
        
        router?.route()
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
}
