//
//  MainRouterType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 27.12.2021.
//

import Foundation
import UIKit

typealias MainEntryPoint = MainViewControllerType & UIViewController

protocol MainRouterType {
    
    var entryPoint: MainEntryPoint? { get }
    
    static func start() -> MainRouterType
    
    func route(to screen: ScreenType)
}
