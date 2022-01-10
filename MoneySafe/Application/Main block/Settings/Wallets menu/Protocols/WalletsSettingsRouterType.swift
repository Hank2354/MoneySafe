//
//  WalletsSettingsRouterType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 01.01.2022.
//

import Foundation
import UIKit

typealias WalletsSettingsEntryPoint = WalletsSettingsViewControllerType & UIViewController

protocol WalletsSettingsRouterType {
    
    var entryPoint: WalletsSettingsEntryPoint? { get }
    
    static func start() -> WalletsSettingsRouterType
    
    func stop()
    
    func route()
}
