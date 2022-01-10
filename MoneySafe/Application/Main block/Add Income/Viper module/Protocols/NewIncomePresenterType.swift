//
//  NewIncomePresenterType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 28.12.2021.
//

import Foundation

protocol NewIncomePresenterType {
    
    var view: NewIncomeViewControllerType?  { get set }
    
    var interactor: NewIncomeInteractorType? { get set }
    
    var router: NewIncomeRouterType? { get set }
    
    func saveButtonPressed()
    
    func backButtonPressed()
    
    func userDataWalletsIsFetched(result: Result<[GeneralWalletModel], Errors>)
    
    func userDataCategoriesIsFetched(result: Result<[GeneralCategoryModel], Errors>)
    
    func changeCategoryViewStatus(tappedView: CategoryView)
    
    func changeWalletViewStatus(tappedView: WalletView)
    
}
