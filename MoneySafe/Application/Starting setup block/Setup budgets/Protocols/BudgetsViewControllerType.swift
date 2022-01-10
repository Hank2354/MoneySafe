//
//  BudgetsViewControllerType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 23.12.2021.
//

import Foundation
import UIKit

protocol BudgetsViewControllerType {
    
    var presenter: BudgetsPresenterType? { get set }
    
    var categoryViews: [CategoryView] { get set }
    
    var budgetTextFields: [BudgetTextField] { get set }
    
    func update(with categories: [GeneralCategoryModel])
    
    func saveSettings()
    
    func backAction()
}
