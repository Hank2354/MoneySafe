//
//  CategoryButton.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 21.12.2021.
//

import UIKit

class CategoryView: UIView {
    
    // MARK: - UI Elements
    var title: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 3
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        
        return label
    }()
    
    var iconImage: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    // MARK: - Properties
    var isActive: Bool = false
    
    var categoryViewType: CategoryType = .expense
    
    var categoryID: String!
    
    // MARK: - Configuration methods
    func config(titleString: String, icon: UIImage?) {
        
        self.backgroundColor = .white
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lazyGray.cgColor
        self.layer.cornerRadius = 24
        
        addSubview(title)
        addSubview(iconImage)
        
        title.text = titleString
        
        if let icon = icon {
            iconImage.image = icon
        } else {
            iconImage.image = .logoDefault
        }
        
        
        iconImage.widthAnchor.constraint(equalTo: iconImage.heightAnchor).isActive = true
        iconImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 17).isActive = true
        iconImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        iconImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
        title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        title.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 8).isActive = true
        title.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        title.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
        
        
    }
    
    func setActiveStyle() {
        
        isActive = true
        
        if categoryViewType == .income {
            self.backgroundColor = .lazyGreen
            self.layer.borderColor = UIColor.mainGreen.cgColor
        }
        
        if categoryViewType == .expense {
            self.backgroundColor = .lazyRed
            self.layer.borderColor = UIColor.mainRed.cgColor
        }
        
    }
    
    func setDefaultStyle() {
        
        isActive = false
        
        self.backgroundColor = .white
        self.layer.borderColor = UIColor.lazyGray.cgColor
    }

    // MARK: - INIT
    init(categoryModel: GeneralCategoryModel) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        config(titleString: categoryModel.categoryName, icon: categoryModel.icon)
        categoryID = categoryModel.categoryID
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
