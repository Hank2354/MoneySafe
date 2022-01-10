//
//  AboutExpensePresenterType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 01.01.2022.
//

import Foundation

protocol AboutExpensePresenterType {
    
    var view: AboutExpenseViewControllerType? { get set }
    
    var interactor: AboutExpenseInteractorType? { get set }
    
    var router: AboutExpenseRouterType? { get set }
    
    func saveButtonPressed()
    
    func backButtonPressed()
    
    func deleteButtonPressed()
    
    func userDataWalletsIsFetched(result: Result<[GeneralWalletModel], Errors>)
    
    func userDataCategoriesIsFetched(result: Result<[GeneralCategoryModel], Errors>)
    
    func transactionDataIsFetched(result: GeneralTransactionModel)
    
    func changeCategoryViewStatus(tappedView: CategoryView)
    
    func changeWalletViewStatus(tappedView: WalletView)
}
