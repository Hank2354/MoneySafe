//
//  CategoriesSettingsInteractor.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 01.01.2022.
//

import Foundation

class CategoriesSettingsInteractor: CategoriesSettingsInteractorType {
    
    var presenter: CategoriesSettingsPresenterType?
    
    var categoryType: CategoryType!
    
    var coreDataManager = CoreDataManager.shared
    
    func createCaregories() {
        
        switch categoryType {
        case .income:
            presenter?.categoriesIsCreated(result: incomeCategories)
        case .expense:
            presenter?.categoriesIsCreated(result: expenseCaregories)
        case .none:
            return
        }
    }
    
    func saveSelectedCategoriesID(IDs: [String]) {
        
        let userSettings = coreDataManager.getUserSettings()
        
        switch userSettings {
            
        case .success(let userSettings):
            
            switch categoryType {
            case .income:
                userSettings.incomeCategoriesID = IDs
            case .expense:
                userSettings.expenseCategoriesID = IDs
            case .none:
                return
            }
            
            coreDataManager.saveContext()
            
        case .failure(let error):
            
            print(error)
            return
            
        }
        
    }
    
    func getCurrentCategoriesID() -> [String] {
        
        let userSettings = coreDataManager.getUserSettings()
        
        switch userSettings {
            
        case .success(let userSettings):
            
            switch categoryType {
            case .income:
                return userSettings.incomeCategoriesID!
            case .expense:
                return userSettings.expenseCategoriesID!
            case .none:
                return []
            }
            
        case .failure(let error):
            
            print(error)
            return []
            
        }
    }
}
