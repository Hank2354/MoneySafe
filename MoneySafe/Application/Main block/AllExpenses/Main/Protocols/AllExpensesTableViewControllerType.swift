//
//  AllExpensesViewControllerType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 30.12.2021.
//

import Foundation

protocol AllExpensesTableViewControllerType {
    
    var presenter: AllExpensesPresenterType? { get set }
    
    var transactions: [[GeneralTransactionModel]] { get set }
    
    func presentWarnMessage(title: String?, message: String?)
    
    func update(with data: [[GeneralTransactionModel]])
}
