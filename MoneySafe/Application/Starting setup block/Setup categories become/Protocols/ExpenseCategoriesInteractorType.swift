//
//  ExpenseCategoriesInteractorType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 23.12.2021.
//

import Foundation

protocol ExpenseCategoriesInteractorType {
    
    var presenter: ExpenseCategoriesPresenterType? { get set }
    
    func createCaregories()
    
    func getSelectedCategoriesID(currentViews: [CategoryView]) -> [String]
}
