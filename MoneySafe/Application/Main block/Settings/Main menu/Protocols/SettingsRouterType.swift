//
//  SettingsRouterType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 30.12.2021.
//

import Foundation
import UIKit

typealias SettingsEntryPoint = SettingsViewControllerType & UIViewController

protocol SettingsRouterType {
    
    var entryPoint: SettingsEntryPoint? { get }
    
    static func start() -> SettingsRouterType
    
    func stop()
    
    func route(to screenType: SettingsScreenType)
}
