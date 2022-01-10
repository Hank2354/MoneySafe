//
//  IncomeCategoriesPresenterType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 21.12.2021.
//

import Foundation

protocol IncomeCategoriesPresenterType {
    
    var interactor: IncomeCategoriesInteractorType? { get set }
    
    var router: IncomeCategoriesRouterType? { get set }
    
    var view: IncomeCategoriesViewControllerType? { get set }
    
    var wallets: [GeneralWalletModel] { get set }
    
    func categoriesIsCreated(result: [GeneralCategoryModel])
    
    func isContinueButtonPressed()
    
    func isBackButtonPressed()
    
    func changeCategoryViewStatus(tappedView: CategoryView)
    
}
