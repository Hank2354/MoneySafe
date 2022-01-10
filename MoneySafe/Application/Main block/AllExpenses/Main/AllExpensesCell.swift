//
//  AllExpensesCell.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 31.12.2021.
//

import Foundation
import UIKit

class AllExpensesCell: UITableViewCell {
    
    // MARK: - UI Elements
    
    var iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    var title: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 1
        
        label.textColor = .black
        
        label.textAlignment = .left
        
        label.sizeToFit()
        
        return label
    }()
    
    var subTitle: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.numberOfLines = 2
        
        label.textColor = .gray
        
        label.textAlignment = .left
        
        
        return label
    }()
    
    var amountLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        
        label.textColor = .mainRed
        
        label.textAlignment = .right
        
        label.sizeToFit()
        
        return label
    }()
    
    var dateLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.numberOfLines = 0
        
        label.textColor = .gray
        
        label.textAlignment = .right
        
        return label
    }()
    
    func configure(transactionModel: GeneralTransactionModel) {
        
        // MARK: - Setup constraints
        let someView = UIView()
        someView.translatesAutoresizingMaskIntoConstraints = false
        someView.backgroundColor = .mainRed
        someView.layer.cornerRadius = 16
        
        someView.addSubview(iconImage)
        someView.addSubview(title)
        someView.addSubview(subTitle)
        someView.addSubview(amountLabel)
        someView.addSubview(dateLabel)
        
        contentView.addSubview(someView)
        
        self.contentView.backgroundColor = .white
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(someView.topAnchor.constraint(equalTo: contentView.topAnchor))
        constraints.append(someView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10))
        constraints.append(someView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10))
        constraints.append(someView.heightAnchor.constraint(equalToConstant: 70))
        
        constraints.append(iconImage.heightAnchor.constraint(equalTo: iconImage.widthAnchor))
        constraints.append(iconImage.centerYAnchor.constraint(equalTo: someView.centerYAnchor))
        constraints.append(iconImage.leadingAnchor.constraint(equalTo: someView.leadingAnchor, constant: 20))
        constraints.append(iconImage.topAnchor.constraint(equalTo: someView.topAnchor, constant: 10))
        constraints.append(iconImage.bottomAnchor.constraint(equalTo: someView.bottomAnchor, constant: -10))
        
        constraints.append(title.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 20))
        constraints.append(title.bottomAnchor.constraint(equalTo: someView.centerYAnchor))
        
        constraints.append(amountLabel.centerYAnchor.constraint(equalTo: someView.centerYAnchor))
        constraints.append(amountLabel.trailingAnchor.constraint(equalTo: someView.trailingAnchor, constant: -15))
        
        constraints.append(dateLabel.trailingAnchor.constraint(equalTo: amountLabel.trailingAnchor))
        constraints.append(dateLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 5))
        
        constraints.append(subTitle.leadingAnchor.constraint(equalTo: title.leadingAnchor))
        constraints.append(subTitle.topAnchor.constraint(equalTo: someView.centerYAnchor, constant: 0))
        constraints.append(subTitle.bottomAnchor.constraint(equalTo: someView.bottomAnchor, constant: -3))
        constraints.append(subTitle.widthAnchor.constraint(equalTo: someView.widthAnchor, multiplier: 0.40))
        
        NSLayoutConstraint.activate(constraints)
        
        self.layer.cornerRadius = 16
        
        // MARK: - Setup data in cell
        iconImage.image = transactionModel.category.icon
        title.text = transactionModel.category.categoryName
        
        if transactionModel.category.categoryID.isExpenseCategoryID() {
            amountLabel.text = "- \(transactionModel.amount)"
            amountLabel.textColor = .mainRed
            someView.backgroundColor = .lightRedForExpenseCell
        } else {
            amountLabel.text = "+ \(transactionModel.amount)"
            amountLabel.textColor = .mainGreen
            someView.backgroundColor = .lightGreenForIncomeCell
        }
        
        subTitle.text = transactionModel.descriptionText
        
        dateLabel.text = Date.formattedDate(date: transactionModel.date)
        
    }
    
}
