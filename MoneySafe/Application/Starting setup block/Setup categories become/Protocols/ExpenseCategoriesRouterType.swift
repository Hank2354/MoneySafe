//
//  ExpenseCategoriesRouterType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 23.12.2021.
//

import Foundation
import UIKit

typealias ExpenseCategoriesEntryPoint = ExpenseCategoriesViewControllerType & UIViewController

protocol ExpenseCategoriesRouterType {
    
    var entryPoint: ExpenseCategoriesEntryPoint? { get }
    
    static func start(with wallets: [GeneralWalletModel], incomeCategoriesID: [String]) -> ExpenseCategoriesRouterType
    
    func stop()
    
    func route(with wallets: [GeneralWalletModel], incomeCategoriesID: [String], expenseCategoriesID: [String])
}
