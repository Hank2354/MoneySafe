//
//  BudgetsSettingsRouterType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 01.01.2022.
//

import Foundation
import UIKit

typealias BudgetsSettingsEntryPoint = BudgetsSettingsViewControllerType & UIViewController

protocol BudgetsSettingsRouterType {
    
    var entryPoint: BudgetsSettingsEntryPoint? { get }
    
    static func start(with expenseCategoriesID: [String]) -> BudgetsSettingsRouterType
    
    func stop()
    
    func stopToMainSettingsScreen()
}
