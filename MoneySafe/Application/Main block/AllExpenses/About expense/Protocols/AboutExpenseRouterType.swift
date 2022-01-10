//
//  AboutExpenseRouterType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 01.01.2022.
//

import Foundation
import UIKit

typealias AboutExpenseEntryPoint = AboutExpenseViewControllerType & UIViewController

protocol AboutExpenseRouterType {
    
    var entryPoint: AboutExpenseEntryPoint? { get }
    
    static func start(with transaction: Transaction) -> AboutExpenseRouterType
    
    func stop()
    
}
