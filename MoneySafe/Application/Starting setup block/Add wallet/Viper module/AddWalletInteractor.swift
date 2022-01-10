//
//  AddWalletInteractor.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 19.12.2021.
//

import Foundation

class AddWalletInteractor: AddWalletInteractorType {
    
    var presenter: AddWalletPresenterType?
    
    func createWallet(withName name: String, cashCount count: String) -> GeneralWalletModel? {
        let balance = Decimal(string: count)
        guard let balance = balance else { return nil }
        
        let wallet = GeneralWalletModel(walletName: name, icon: nil, balance: balance)
        
        return wallet
    }
}
