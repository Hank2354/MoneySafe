//
//  AddCashInteractorType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 19.12.2021.
//

import Foundation

protocol AddCashInteractorType {
    
    var presenter: AddCashPresenterType? { get set }
    
    func createWallet(cashCount count: String) -> GeneralWalletModel?
}
