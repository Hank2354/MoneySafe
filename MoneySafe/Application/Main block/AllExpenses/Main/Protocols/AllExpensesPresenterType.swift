//
//  AllExpensesPresenterType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 30.12.2021.
//

import Foundation

protocol AllExpensesPresenterType {
    
    var view: AllExpensesTableViewControllerType? { get set }
    
    var interactor: AllExpensesInteractorType? { get set }
    
    var router: AllExpensesRouterType? { get set }
    
    func backButtonPressed()
    
    func isTransactionDataFethed(data: [[GeneralTransactionModel]]?, error: Errors?)
    
    func transactionTapped(model: GeneralTransactionModel)
    
    func updateData()
    
}
