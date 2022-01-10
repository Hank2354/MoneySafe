//
//  Page.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 18.12.2021.
//

import Foundation
import UIKit

class Page: UICollectionViewCell {
    
    // MARK: - UI Elements
    var imageView:          UIImageView   = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    var headerLabel:        UILabel       = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        label.text = "Заголовок"
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        
        label.sizeToFit()
        
        return label
    }()
    
    var descriptionLabel:   UILabel       = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        label.text = "Описание"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        
        return label
    }()
    
    // MARK: - Configuration methods
    private func setupLayout()         {
        addSubview(imageView)
        addSubview(headerLabel)
        addSubview(descriptionLabel)
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(headerLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: self.frame.height * 0.15))
        constraints.append(headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20))
        constraints.append(headerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20))
        constraints.append(headerLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 83))
        
        constraints.append(descriptionLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 15))
        constraints.append(descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20))
        constraints.append(descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20))
        
        constraints.append(imageView.topAnchor.constraint(greaterThanOrEqualTo: descriptionLabel.bottomAnchor, constant: 15))
        constraints.append(imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40))
        constraints.append(imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40))
        constraints.append(imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func configure(model: PageModel)   {
        setupLayout()
        
        imageView.image = model.image
        headerLabel.text = model.header
        descriptionLabel.text = model.description
    }
    
    // MARK: - INIT
    required init?(coder: NSCoder)     {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect)       {
        super.init(frame: frame)
    }
}
