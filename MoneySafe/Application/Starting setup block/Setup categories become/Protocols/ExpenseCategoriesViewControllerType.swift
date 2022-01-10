//
//  ExpenseCategoriesViewControllerType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 23.12.2021.
//

import Foundation
import UIKit

protocol ExpenseCategoriesViewControllerType {
    
    var presenter: ExpenseCategoriesPresenterType? { get set }
    
    var categoryViews: [CategoryView] { get set }
    
    var continueButton: UIButton { get set }
    
    func update(with categories: [GeneralCategoryModel])
    
    func saveCategoriesAction()
    
    func backAction()
}
