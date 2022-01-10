//
//  IncomeCategoriesPresenter.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 21.12.2021.
//

import Foundation

class IncomeCategoriesPresenter: IncomeCategoriesPresenterType {
    
    var interactor: IncomeCategoriesInteractorType?
    
    var router: IncomeCategoriesRouterType?
    
    var view: IncomeCategoriesViewControllerType?
    
    var wallets = [GeneralWalletModel]()
        
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
        
        let currentCategoriesID = interactor?.getSelectedCategoriesID(currentViews: currentCategoryViews)
        guard let currentCategoriesID = currentCategoriesID else { return }
        
        router?.route(with: wallets, incomeCategoriesID: currentCategoriesID)
        
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
