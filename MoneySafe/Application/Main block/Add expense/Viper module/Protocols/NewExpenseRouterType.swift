//
//  NewExpenseRouterType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 28.12.2021.
//

import Foundation
import UIKit

typealias NewExpenseEntryPoint = NewExpenseViewControllerType & UIViewController

protocol NewExpenseRouterType {
    
    var entryPoint: NewExpenseEntryPoint? { get }
    
    static func start() -> NewExpenseRouterType
    
    func stop()
}
