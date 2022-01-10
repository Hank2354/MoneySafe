//
//  WalletView.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 28.12.2021.
//

import Foundation
import UIKit

class WalletView: UIView {
    
    // MARK: - UI Elements
    var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        
        label.textAlignment = .center
        
        return label
    }()
    
    var balanceLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        
        label.textAlignment = .center
        
        label.textColor = .darkGrayForBudget
        
        return label
    }()

    // MARK: - Properties
    var isActive: Bool = false
    
    // MARK: - Configuration methods
    func config() {
        
        self.backgroundColor = .white
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lazyGray.cgColor
        self.layer.cornerRadius = 24
        
        addSubview(titleLabel)
        addSubview(balanceLabel)
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor))
        constraints.append(titleLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: -3))
        constraints.append(titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10))
        constraints.append(titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10))
        
        constraints.append(balanceLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor))
        constraints.append(balanceLabel.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 3))
        constraints.append(balanceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10))
        constraints.append(balanceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10))
        
        NSLayoutConstraint.activate(constraints)
    }

    func setActiveStyle() {
        
        isActive = true
        
        self.backgroundColor = .lazyBlue
        self.layer.borderColor = UIColor.mainBlue.cgColor
    }

    func setDefaultStyle() {
        
        isActive = false
        
        self.backgroundColor = .white
        self.layer.borderColor = UIColor.lazyGray.cgColor
    }

    // MARK: - INIT
    init(walletModel: GeneralWalletModel) {
        super.init(frame: .zero)
        
        titleLabel.text = walletModel.walletName
        balanceLabel.text = "\(walletModel.balance) ₽"
        
        config()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
