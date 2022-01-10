//
//  NewIncomeInteractorType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 28.12.2021.
//

import Foundation

protocol NewIncomeInteractorType {
    
    var presenter: NewIncomePresenterType? { get set }
    
    func fetchUserData()
    
    func saveTransaction(walletName: String,
                         categoryID: String,
                         transactionDetail: String?,
                         amount: Decimal) -> Result<String, Errors> 
}
