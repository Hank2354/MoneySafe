//
//  IncomeCategoriesRouterType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 21.12.2021.
//

import Foundation
import UIKit

typealias IncomeCategoriesEntryPoint = IncomeCategoriesViewControllerType & UIViewController

protocol IncomeCategoriesRouterType {
    
    var entryPoint: IncomeCategoriesEntryPoint? { get }
    
    static func start(with wallets: [GeneralWalletModel]) -> IncomeCategoriesRouterType
    
    func stop()
    
    func route(with wallets: [GeneralWalletModel], incomeCategoriesID: [String])
}
