//
//  CategoriesSettingsPresenterType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 01.01.2022.
//

import Foundation

protocol CategoriesSettingsPresenterType {
    
    var view: CategoriesSettingsViewControllerType? { get set }
    
    var interactor: CategoriesSettingsInteractorType? { get set }
    
    var router: CategoriesSettingsRouterType? { get set }
    
    func categoriesIsCreated(result: [GeneralCategoryModel])
    
    func isSaveButtonPressed()
    
    func isBackButtonPressed()
    
    func changeCategoryViewStatus(tappedView: CategoryView)
}
