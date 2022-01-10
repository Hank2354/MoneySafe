//
//  CategoriesSettingsViewControllerType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 01.01.2022.
//

import Foundation

protocol CategoriesSettingsViewControllerType {
    
    var presenter: CategoriesSettingsPresenterType? { get set }
    
    var categoryViews: [CategoryView] { get set }
    
    func update(with categories: [GeneralCategoryModel])
    
    func saveCategories()
    
    func backAction()
}
