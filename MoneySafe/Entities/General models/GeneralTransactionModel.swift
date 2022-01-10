//
//  GeneralTransactionModel.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 31.12.2021.
//

import Foundation

struct GeneralTransactionModel {
    let category: GeneralCategoryModel
    let descriptionText: String
    let amount: Decimal
    let date: Date
    let walletName: String
    let transactionMO: Transaction
}
