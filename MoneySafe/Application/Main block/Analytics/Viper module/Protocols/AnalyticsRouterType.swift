//
//  AnalyticsRouterType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 30.12.2021.
//

import Foundation
import UIKit

typealias AnalyticsEntryPoint = AnalyticsViewControllerType & UIViewController


protocol AnalyticsRouterType {
    
    var entryPoint: AnalyticsEntryPoint? { get }
    
    static func start() -> AnalyticsRouterType
    
    func stop()
    
    func route()
}
