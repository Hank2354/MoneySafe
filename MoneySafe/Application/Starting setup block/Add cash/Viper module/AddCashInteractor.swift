//
//  Interactor.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 19.12.2021.
//

import Foundation

class AddCashInteractor: AddCashInteractorType {
    
    var presenter: AddCashPresenterType?
    
    func createWallet(cashCount count: String) -> GeneralWalletModel? {
        let balance = Decimal(string: count)
        guard let balance = balance else { return nil }
        
        let wallet = GeneralWalletModel(walletName: "Наличные", icon: nil, balance: balance)
        
        return wallet
    }
}
