//
//  MainInteractorType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 27.12.2021.
//

import Foundation

protocol MainInteractorType {
    
    var presenter: MainPresenterType? { get set }
    
    func fetchUserData()
    
    func getCurrentMouth() -> String
    
    func getTotalBalance() -> Result<Decimal, Errors>
    
    func getbudgetsWithTransactions() -> Result<[GeneralActualBudgetModel], Errors>
}
