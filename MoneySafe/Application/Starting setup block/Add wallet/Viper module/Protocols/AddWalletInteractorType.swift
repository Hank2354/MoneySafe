//
//  AddWalletInteractorType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 19.12.2021.
//

import Foundation

protocol AddWalletInteractorType {
    
    var presenter: AddWalletPresenterType? { get set }
    
    func createWallet(withName name: String, cashCount count: String) -> GeneralWalletModel?
    
}
