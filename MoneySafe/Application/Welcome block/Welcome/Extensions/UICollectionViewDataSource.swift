//
//  UICollectionViewDataSource.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 18.12.2021.
//

import Foundation
import UIKit

// MARK: - UICollectionViewDataSource

extension WelcomeController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? Page
        
        guard let cell = cell else { return UICollectionViewCell() }
        
        let currentPageModel = pages[indexPath.item]
        
        cell.configure(model: currentPageModel)
        
        return cell
    }
    
}
