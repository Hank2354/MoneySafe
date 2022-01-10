//
//  NewWalletRouterType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 02.01.2022.
//

import Foundation
import UIKit

typealias NewWalletEntryPoint = NewWalletViewControllerType & UIViewController

protocol NewWalletRouterType {
    
    var entryPoint: NewWalletEntryPoint? { get }
    
    static func start() -> NewWalletRouterType
    
    func stop()
}
