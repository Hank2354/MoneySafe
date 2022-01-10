//
//  AllExpensesRouterType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 30.12.2021.
//

import Foundation
import UIKit

typealias AllExpensesEntryPoint = AllExpensesTableViewControllerType & UITableViewController

protocol AllExpensesRouterType {
    
    var entryPoint: AllExpensesEntryPoint? { get }
    
    static func start() -> AllExpensesRouterType
    
    func stop()
    
    func route(transaction: Transaction)
}
