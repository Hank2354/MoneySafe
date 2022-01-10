//
//  CategoriesSettingsPresenter.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 01.01.2022.
//

import Foundation

class CategoriesSettingsPresenter: CategoriesSettingsPresenterType {
    
    var view: CategoriesSettingsViewControllerType?
    
    var interactor: CategoriesSettingsInteractorType?
    
    var router: CategoriesSettingsRouterType?
    
    func categoriesIsCreated(result: [GeneralCategoryModel]) {
        view?.update(with: result)
        
        let selectedCategoriesID = interactor?.getCurrentCategoriesID()
        
        guard let selectedCategoriesID = selectedCategoriesID else { return }
        
        for view in view?.categoryViews ?? [] {
            
            for categoryID in selectedCategoriesID {
                
                if view.categoryID == categoryID {
                    
                    view.setActiveStyle()
                    
                }
                
            }
            
        }
    }
    
    func isSaveButtonPressed() {
        
        var currentCategoryViews = [CategoryView]()
        
        for element in view!.categoryViews {
            if element.isActive {
                currentCategoryViews.append(element)
            }
        }
        
        var selectedCategoriesID = [String]()
        
        for element in currentCategoryViews {
            selectedCategoriesID.append(element.categoryID)
        }
        
        if interactor!.categoryType == .expense {
            router?.route(with: selectedCategoriesID)
        } else {
            interactor?.saveSelectedCategoriesID(IDs: selectedCategoriesID)
            router?.stop()
        }
        
        
        
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
