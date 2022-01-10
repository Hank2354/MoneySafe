//
//  ActionType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 29.12.2021.
//

import Foundation

@objc enum ActionType: Int {
    case newExpense
    case newIncome
    case analytics
    case allExpenses
    case settings
}
