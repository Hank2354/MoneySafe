//
//  UICollectionViewDelegateFlowLayout.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 18.12.2021.
//

import Foundation
import UIKit

// MARK: - UICollectionViewDelegateFlowLayout

extension WelcomeController {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
