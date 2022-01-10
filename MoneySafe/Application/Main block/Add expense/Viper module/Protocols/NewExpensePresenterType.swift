//
//  NewExpensePresenterType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 28.12.2021.
//

import Foundation

protocol NewExpensePresenterType {
    
    var view: NewExpenseViewControllerType?  { get set }
    
    var interactor: NewExpenseInteractorType? { get set }
    
    var router: NewExpenseRouterType? { get set }
    
    func saveButtonPressed()
    
    func backButtonPressed()
    
    func userDataWalletsIsFetched(result: Result<[GeneralWalletModel], Errors>)
    
    func userDataCategoriesIsFetched(result: Result<[GeneralCategoryModel], Errors>)
    
    func changeCategoryViewStatus(tappedView: CategoryView)
    
    func changeWalletViewStatus(tappedView: WalletView)
    
}
