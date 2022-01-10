//
//  Errors.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 28.12.2021.
//

import Foundation

enum Errors: Error {
    case loadWalletsError
    case loadUserSettingsError
    case loadUserBudgetsError
    case loadTransactionsError
    case incorrectWalletName
}
