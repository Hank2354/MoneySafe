//
//  WalletsSettingsViewControllerType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 01.01.2022.
//

import Foundation
import UIKit

protocol WalletsSettingsViewControllerType {
    
    var presenter: WalletsSettingsPresenterType? { get set }
    
    var wallets: [GeneralWalletModel] { get set }
    
    func update(with walletModels: [GeneralWalletModel])
    
    func presentController(alertController: UIAlertController)
}
