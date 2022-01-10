//
//  WalletSettingsUICollectionViewDataSource.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 02.01.2022.
//

import Foundation
import UIKit

extension WalletsSettingsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        wallets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as? CustomCell
        
        guard let cell = cell else { return UICollectionViewCell() }
        
        let currentModel = wallets[indexPath.row]
        
        let settingsButton = SettingsButton(titleText: currentModel.walletName,
                                            subTitleText: "\(currentModel.balance)",
                                            logo: nil,
                                            style: .small)
        
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        
        settingsButton.config()
        
        settingsButton.isUserInteractionEnabled = false
        
        cell.customView = settingsButton
        
        cell.config()
        
        return cell
    }
    
    
    
    
    
}
