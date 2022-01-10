//
//  WalletsSettingsPresenterType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 01.01.2022.
//

import Foundation
import UIKit

protocol WalletsSettingsPresenterType {
    
    var view: WalletsSettingsViewControllerType? { get set }
    
    var interactor: WalletsSettingsInteractorType? { get set }
    
    var router: WalletsSettingsRouterType? { get set }
    
    func isBackButtonPressed()
    
    func isAddWalletButtonPressed()
    
    func isWalletsDataFetched(walletModels: [GeneralWalletModel])
    
    func isWalletButtonTapped(walletModel: GeneralWalletModel)
    
    func updateData()
    
}
