//
//  ExpenseCategoriesInteractor.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 23.12.2021.
//

import Foundation

class ExpenseCategoriesInteractor: ExpenseCategoriesInteractorType {
    
    var presenter: ExpenseCategoriesPresenterType?
    
    func createCaregories() {
        presenter?.categoriesIsCreated(result: expenseCaregories)
    }
    
    func getSelectedCategoriesID(currentViews: [CategoryView]) -> [String] {
        
        var currentCategoriesID = [String]()
        var currentCategoryNames = [String]()
        
        for currentView in currentViews {
            currentCategoryNames.append(currentView.title.text ?? "")
        }
        
        for category in expenseCaregories {
            let categoryName = category.categoryName
            
            for currentCategoryName in currentCategoryNames {
                
                if categoryName == currentCategoryName {
                    currentCategoriesID.append(category.categoryID)
                }
            }
            
        }
        
        return currentCategoriesID
    }
    
}
