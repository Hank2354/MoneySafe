//
//  FunctionButton.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 27.12.2021.
//

import Foundation
import UIKit

class FunctionButton: UIButton {
    
    // MARK: - UI Elements
    var title: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        
        label.textColor = .white
        
        label.textAlignment = .center
        
        label.sizeToFit()
        
        return label
    }()
    
    var iconImage: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    // MARK: - UI Elements
    func config() {
        
        self.addSubview(title)
        self.addSubview(iconImage)
        
        self.heightAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        iconImage.heightAnchor.constraint(equalTo: iconImage.widthAnchor).isActive = true
        iconImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        iconImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 7).isActive = true
        iconImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25).isActive = true
        
        title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        title.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: 7).isActive = true
        title.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
        self.layer.cornerRadius = 28
        
    }
    
    // MARK: - INIT
    init(titleText: String, logo: UIImage?) {
        super.init(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        title.text = titleText
        iconImage.image = logo
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
