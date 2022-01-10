//
//  SettingsButton.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 31.12.2021.
//

import Foundation
import UIKit

class SettingsButton: UIButton {
    
    // MARK: - UI Elements
    var title: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        
        label.textColor = .black
        
        label.textAlignment = .left
        
        label.sizeToFit()
        
        return label
    }()
    
    var subTitle: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        
        label.textColor = .black
        
        label.textAlignment = .right
        
        label.sizeToFit()
        
        return label
    }()
    
    var iconImage: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    // MARK: - Properties
    var styleType: SettingsButtonStyle!
    
    // MARK: - UI Elements
    func config() {
        
        self.addSubview(title)
        self.addSubview(subTitle)
        
        self.backgroundColor = .white
        
        self.layer.cornerRadius = 16
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(subTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor))
        constraints.append(subTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5))
        constraints.append(title.centerYAnchor.constraint(equalTo: self.centerYAnchor))
        
        switch styleType {
            
        case .large:
            
            self.addSubview(iconImage)
            
            constraints.append(iconImage.centerYAnchor.constraint(equalTo: self.centerYAnchor))
            constraints.append(iconImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10))
            constraints.append(iconImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10))
            constraints.append(iconImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10))
            constraints.append(iconImage.heightAnchor.constraint(equalTo: iconImage.widthAnchor))
            
            constraints.append(title.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 20))
            
        case .small:
            
            constraints.append(title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10))
            
            title.font = UIFont.boldSystemFont(ofSize: 14)
            subTitle.font = UIFont.boldSystemFont(ofSize: 16)
            
        case .none:
            return
        }
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    // MARK: - INIT
    init(titleText: String, subTitleText: String?, logo: UIImage?, style: SettingsButtonStyle) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        
        title.text = titleText
        subTitle.text = subTitleText
        iconImage.image = logo ?? .logoDefault
        styleType = style
        
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
