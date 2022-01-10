//
//  CategoriesSettingsInteractorType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 01.01.2022.
//

import Foundation

protocol CategoriesSettingsInteractorType {
    
    var presenter: CategoriesSettingsPresenterType? { get set }
    
    var categoryType: CategoryType! { get set }
    
    func createCaregories()
    
    func saveSelectedCategoriesID(IDs: [String])
    
    func getCurrentCategoriesID() -> [String]
}
