//
//  WalletsSettingsInteractorType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 01.01.2022.
//

import Foundation

protocol WalletsSettingsInteractorType {
    
    var presenter: WalletsSettingsPresenterType? { get set }
    
    func fetchUserWalletsWithCurrentBalance()
    
    func disactiveWallet(wallet: Wallet)
    
    func changeWalletName(wallet: Wallet, newName: String) -> Result<Any, Errors>
}
