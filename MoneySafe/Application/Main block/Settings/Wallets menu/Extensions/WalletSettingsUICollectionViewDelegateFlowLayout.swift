//
//  WalletSettingsUICollectionViewDelegateFlowLayout.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 02.01.2022.
//

import Foundation
import UIKit

extension WalletsSettingsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let viewWidth = (view.frame.size.width)
        let currentWidth = viewWidth - 40
        
        return CGSize(width: currentWidth, height: 50)
        
    }
    
}
