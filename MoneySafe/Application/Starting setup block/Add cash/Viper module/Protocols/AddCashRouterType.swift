//
//  AddCashRouterType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 19.12.2021.
//

import Foundation
import UIKit

typealias AddCashEntryPoint = AddCashViewControllerType & UIViewController

protocol AddCashRouterType {
    
    var entryPoint: AddCashEntryPoint? { get }
    
    static func start() -> AddCashRouterType
    
    func route(with wallet: GeneralWalletModel?) 
}
