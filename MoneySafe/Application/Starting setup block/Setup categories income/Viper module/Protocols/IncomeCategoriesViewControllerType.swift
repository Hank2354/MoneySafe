//
//  IncomeCategoriesViewControllerType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 21.12.2021.
//

import Foundation
import UIKit

protocol IncomeCategoriesViewControllerType {
    
    var presenter: IncomeCategoriesPresenterType? { get set }
    
    var categoryViews: [CategoryView] { get set }
    
    func update(with categories: [GeneralCategoryModel])
    
    func saveCategories()
    
    func backAction()
}
