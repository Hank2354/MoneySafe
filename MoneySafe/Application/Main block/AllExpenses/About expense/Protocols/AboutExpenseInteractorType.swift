//
//  AboutExpenseInteractorType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 01.01.2022.
//

import Foundation

protocol AboutExpenseInteractorType {
    
    var presenter: AboutExpensePresenterType? { get set }
    
    var selectedTransaction: Transaction! { get set }
    
    func fetchUserData()
    
    func saveChanges(walletName: String,
                     categoryID: String,
                     transactionDetail: String?,
                     amount: Decimal,
                     date: Date) -> Result<String, Errors>
    
    func deleteSelectedTransaction()
    
    func getSelectedTransactionData() -> GeneralTransactionModel
    
    func getSelectedTransactionWalletName() -> String
    
    func getSelectedCategoryID() -> String
}
