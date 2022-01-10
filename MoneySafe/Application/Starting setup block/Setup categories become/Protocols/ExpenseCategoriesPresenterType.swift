//
//  ExpenseCategoriesPresenterType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 23.12.2021.
//

import Foundation

protocol ExpenseCategoriesPresenterType {
    
    var interactor: ExpenseCategoriesInteractorType? { get set }
    
    var router: ExpenseCategoriesRouterType? { get set }
    
    var view: ExpenseCategoriesViewControllerType? { get set }
    
    var wallets: [GeneralWalletModel] { get set }
    
    var incomeCategoriesID: [String] { get set }
    
    func categoriesIsCreated(result: [GeneralCategoryModel])
    
    func isContinueButtonPressed()
    
    func isBackButtonPressed()
    
    func changeCategoryViewStatus(tappedView: CategoryView)
    
}
