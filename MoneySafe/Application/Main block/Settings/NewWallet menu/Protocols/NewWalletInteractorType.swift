//
//  NewWalletInteractorType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 02.01.2022.
//

import Foundation

protocol NewWalletInteractorType {
    
    var presenter: NewWalletPresenterType? { get set }
    
    func saveWallet(walletName: String, startBalance: Decimal) -> Result<String, Errors>
}
