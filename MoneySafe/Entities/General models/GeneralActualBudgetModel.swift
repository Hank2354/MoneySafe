//
//  GeneralActualBudgetModel.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 27.12.2021.
//

import Foundation

struct GeneralActualBudgetModel {
    let category: GeneralCategoryModel?
    let budget: Decimal
    let totalExpenses: Decimal
}
