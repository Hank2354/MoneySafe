//
//  BudgetsPresenterType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 23.12.2021.
//

import Foundation

protocol BudgetsPresenterType {
    
    var interactor: BudgetsInteractorType? { get set }
    
    var router: BudgetsRouterType? { get set }
    
    var view: BudgetsViewControllerType? { get set }
    
    var wallets: [GeneralWalletModel] { get set }
    
    var incomeCategoriesID: [String] { get set }
    
    var expenseCategoriesID: [String] { get set }
    
    func categoriesIsCreated(result: [GeneralCategoryModel])
    
    func isContinueButtonPressed()
    
    func isBackButtonPressed()
    
    func isDoneButtonPressed()
    
}
