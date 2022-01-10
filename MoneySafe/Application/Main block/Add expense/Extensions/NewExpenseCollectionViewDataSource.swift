//
//  NewExpenseCollectionViewDataSource.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 01.01.2022.
//

import Foundation
import UIKit

extension NewExpenseViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView.tag {
        case 1:
            return walletViews.count
        case 2:
            return categoryViews.count
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell: CustomCell
        
        switch collectionView.tag {
            
        case 1:
            
            let _cell = collectionView.dequeueReusableCell(withReuseIdentifier: "walletCell", for: indexPath) as? CustomCell
            
            guard let _cell = _cell else { return UICollectionViewCell() }
            
            _cell.customView = walletViews[indexPath.row]
            
            cell = _cell
            
        case 2:
            
            let _cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as? CustomCell
            
            guard let _cell = _cell else { return UICollectionViewCell() }
            
            _cell.customView = categoryViews[indexPath.row]
            
            cell = _cell
            
        default:
            
            return UICollectionViewCell()
            
        }
        
        cell.config()
        
        return cell
        
    }
    
    
}
