//
//  ExpenseCategoriesPresenter.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 23.12.2021.
//

import Foundation

class ExpenseCategoriesPresenter: ExpenseCategoriesPresenterType {
    
    var interactor: ExpenseCategoriesInteractorType?
    
    var router: ExpenseCategoriesRouterType?
    
    var view: ExpenseCategoriesViewControllerType?
    
    var wallets = [GeneralWalletModel]()
    
    var incomeCategoriesID = [String]()
        
    func categoriesIsCreated(result: [GeneralCategoryModel]) {
        view?.update(with: result)
    }
    
    func isContinueButtonPressed() {
        
        var currentCategoryViews = [CategoryView]()
        
        for element in view?.categoryViews ?? [] {
            if element.isActive {
                currentCategoryViews.append(element)
            }
        }
        
        let expenseCategoriesID = interactor?.getSelectedCategoriesID(currentViews: currentCategoryViews)
        guard let expenseCategoriesID = expenseCategoriesID else { return }
        
        router?.route(with: wallets, incomeCategoriesID: incomeCategoriesID, expenseCategoriesID: expenseCategoriesID)
        
    }
    
    func isBackButtonPressed() {
        router?.stop()
    }
    
    func changeCategoryViewStatus(tappedView: CategoryView) {
        if tappedView.isActive {
            tappedView.setDefaultStyle()
        } else {
            tappedView.setActiveStyle()
        }
    }
    
}
