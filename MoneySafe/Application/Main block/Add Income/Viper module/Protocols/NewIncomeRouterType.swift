//
//  NewIncomeRouterType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 28.12.2021.
//

import Foundation
import UIKit

typealias NewIncomeEntryPoint = NewIncomeViewControllerType & UIViewController

protocol NewIncomeRouterType {
    
    var entryPoint: NewIncomeEntryPoint? { get }
    
    static func start() -> NewIncomeRouterType
    
    func stop()
}
