//
//  BudgetsRouterType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 23.12.2021.
//

import Foundation
import UIKit

typealias BudgetsEntryPoint = BudgetsViewControllerType & UIViewController

protocol BudgetsRouterType {
    
    var entryPoint: BudgetsEntryPoint? { get }
    
    static func start(with wallets: [GeneralWalletModel], incomeCategoriesID: [String], expenseCategoriesID: [String]) -> BudgetsRouterType
    
    func stop()
    
    func route()
}
