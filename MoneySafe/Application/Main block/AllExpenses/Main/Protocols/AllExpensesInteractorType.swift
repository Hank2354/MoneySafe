//
//  AllExpensesInteractorType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 30.12.2021.
//

import Foundation

protocol AllExpensesInteractorType {
    
    var presenter: AllExpensesPresenterType? { get set }
    
    func getTransactionData()
}
