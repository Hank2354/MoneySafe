//
//  GeneralMainAnalyticsModel.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 05.01.2022.
//

import Foundation

struct GeneralMainAnalyticsModel {
    let month: String
    let year: String
    let totalExpensesBalance: Decimal
    let data: [MainAnalyticsDataModel]
}
