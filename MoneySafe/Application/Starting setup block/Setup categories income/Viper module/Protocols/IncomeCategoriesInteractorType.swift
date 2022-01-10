//
//  IncomeCategoriesInteractorType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 21.12.2021.
//

import Foundation

protocol IncomeCategoriesInteractorType {
    
    var presenter: IncomeCategoriesPresenterType? { get set }
    
    func createCaregories()
    
    func getSelectedCategoriesID(currentViews: [CategoryView]) -> [String]
}
