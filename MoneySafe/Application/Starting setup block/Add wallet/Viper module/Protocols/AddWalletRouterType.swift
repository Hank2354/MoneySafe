//
//  AddWalletRouterType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 19.12.2021.
//

import Foundation
import UIKit

typealias AddWalletEntryPoint = AddWalletViewControllerType & UIViewController

protocol AddWalletRouterType {
    
    var entryPoint: AddWalletEntryPoint? { get }
    
    static func start(with wallet: GeneralWalletModel?) -> AddWalletRouterType
    
    func stop()
    
    func route(with wallet: [GeneralWalletModel])
}
