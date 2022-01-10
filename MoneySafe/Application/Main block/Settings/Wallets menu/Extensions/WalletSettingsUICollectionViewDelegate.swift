//
//  WalletSettingsUICollectionViewDelegate.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 02.01.2022.
//

import Foundation
import UIKit

extension WalletsSettingsViewController: UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let tappedButtonWalletModel = wallets[indexPath.row]
        
        presenter?.isWalletButtonTapped(walletModel: tappedButtonWalletModel)
    }
    
}
