//
//  AddTransactionButton.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 27.12.2021.
//

import Foundation
import UIKit

class AddTransactionButton: UIButton {
    
    // MARK: - UI Elements
    var title: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        
        label.textColor = .white
        
        label.textAlignment = .center
        
        return label
    }()
    
    var iconImage: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    // MARK: - Properties
    var transactionType: CategoryType?
    
    // MARK: - Configuration methods
    func config() {
        
        self.addSubview(title)
        self.addSubview(iconImage)
        
        iconImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 17).isActive = true
        iconImage.heightAnchor.constraint(equalTo: iconImage.widthAnchor).isActive = true
        iconImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        iconImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        iconImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
        title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -17).isActive = true
        title.leadingAnchor.constraint(greaterThanOrEqualTo: iconImage.trailingAnchor, constant: 5).isActive = true
        title.leadingAnchor.constraint(lessThanOrEqualTo: iconImage.trailingAnchor, constant: 10).isActive = true
        title.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        title.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
        self.layer.cornerRadius = 28
        
        if transactionType == .income {
            title.text = "Новый\nдоход"
            iconImage.image = .logoIncome
            self.backgroundColor = .mainGreen
        }
        
        if transactionType == .expense {
            title.text = "Новый\nрасход"
            iconImage.image = .logoExpense
            self.backgroundColor = .mainRed
        }
        
    }
    
    // MARK: - INIT
    init(type: CategoryType) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        transactionType = type
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
