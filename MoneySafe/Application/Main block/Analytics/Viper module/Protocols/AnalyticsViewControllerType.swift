//
//  AnalyticsViewControllerType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 30.12.2021.
//

import Foundation
import UIKit

protocol AnalyticsViewControllerType {
    
    var presenter: AnalyticsPresenterType? { get set }
    
    var currentMonth: String { get set }
    
    var currentYear: String { get set }
    
    func update(with pieData: GeneralMainAnalyticsModel, barData: GeneralBarAnalyticsModel, totalBudget: Decimal, totalExpensesMonth: Decimal)
    
    func presentWarnMessage(alertController: UIAlertController)
}
