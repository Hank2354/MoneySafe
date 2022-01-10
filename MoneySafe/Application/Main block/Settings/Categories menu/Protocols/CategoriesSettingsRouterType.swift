//
//  CategoriesSettingsRouterType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 01.01.2022.
//

import Foundation
import UIKit

typealias CategoriesSettingsEntryPoint = CategoriesSettingsViewControllerType & UIViewController

protocol CategoriesSettingsRouterType {
    
    var entryPoint: CategoriesSettingsEntryPoint? { get }
    
    static func start(categoryType: CategoryType) -> CategoriesSettingsRouterType
    
    func stop()
    
    func route(with expenseCategories: [String])
}
