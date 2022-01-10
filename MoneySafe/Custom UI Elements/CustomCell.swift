//
//  CustomCell.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 01.01.2022.
//

import UIKit

class CustomCell: UICollectionViewCell {
    
    var customView: UIView?
    
    func config() {
        
        guard let customView = customView else { return }

        self.addSubview(customView)
        
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: self.topAnchor),
            customView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            customView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
