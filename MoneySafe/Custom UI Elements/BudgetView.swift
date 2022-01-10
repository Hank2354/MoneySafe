//
//  BudgetCell.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 28.12.2021.
//

import Foundation
import UIKit
import MultiProgressView

class BudgetView: UIView {
    
    // MARK: - UI Elements
    let categoryNameLabel: UILabel = {
        
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.numberOfLines = 1
        
        label.textColor = .black
        
        return label
    }()
    
    let spentMoneyLabel: UILabel = {
        
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.numberOfLines = 1
        
        label.textColor = .darkGrayForBudget
        
        label.textAlignment = .left
        
        return label
    }()
    
    let budgetLabel: UILabel = {
        
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.numberOfLines = 1
        
        label.textColor = .darkBlueForBudget
        
        label.textAlignment = .right
        
        return label
    }()
    
    lazy var progressBar: MultiProgressView = {
        
        let bar = MultiProgressView()
        bar.translatesAutoresizingMaskIntoConstraints = false
        
        bar.backgroundColor = .lightGrayForEmptyBar
        bar.cornerRadius = 5
        bar.lineCap = .round
        bar.borderColor = .mainGreen
        
        bar.pos = getCurrentProgressBarPosition()
        
        return bar
    }()
    
    // MARK: - Configuration methods
    func getCurrentProgressBarPosition() -> Float {
        let budget: Float = (budgetLabel.text! as NSString).floatValue
        
        if budget > 0 {
            return ((spentMoneyLabel.text! as NSString).floatValue * 100/budget) / 100
        }
        
        return 0
    }
    
    func config() {
        self.addSubview(progressBar)
        self.addSubview(categoryNameLabel)
        self.addSubview(spentMoneyLabel)
        self.addSubview(budgetLabel)
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(categoryNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10))
        constraints.append(categoryNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10))
        constraints.append(categoryNameLabel.bottomAnchor.constraint(equalTo: progressBar.topAnchor, constant: -8))
        
        constraints.append(spentMoneyLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10))
        constraints.append(spentMoneyLabel.trailingAnchor.constraint(equalTo: progressBar.centerXAnchor))
        constraints.append(spentMoneyLabel.centerYAnchor.constraint(equalTo: progressBar.centerYAnchor))
        
        constraints.append(budgetLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10))
        constraints.append(budgetLabel.leadingAnchor.constraint(equalTo: progressBar.centerXAnchor))
        constraints.append(budgetLabel.centerYAnchor.constraint(equalTo: progressBar.centerYAnchor))
        
        constraints.append(progressBar.bottomAnchor.constraint(equalTo: self.bottomAnchor))
        constraints.append(progressBar.leadingAnchor.constraint(equalTo: self.leadingAnchor))
        constraints.append(progressBar.trailingAnchor.constraint(equalTo: self.trailingAnchor))
        constraints.append(progressBar.topAnchor.constraint(equalTo: self.centerYAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - INIT
    init(budgetModel: GeneralActualBudgetModel) {
        super.init(frame: .zero)
        
        categoryNameLabel.text = budgetModel.category!.categoryName
        budgetLabel.text = budgetModel.budget > 0 ? "\(budgetModel.budget) ₽" : "Бюджет не установлен"
        spentMoneyLabel.text = "\(budgetModel.totalExpenses) ₽"
        
        if budgetModel.totalExpenses >= budgetModel.budget && budgetModel.budget > 0 {
            self.categoryNameLabel.textColor = .mainRed
        }
        
        config()
    }
    
    init(title: String, currentValue: Decimal, maxValue: Decimal) {
        super.init(frame: .zero)
        
        categoryNameLabel.text = title
        budgetLabel.text = maxValue > 0 ? "\(maxValue) ₽" : ""
        spentMoneyLabel.text = "\(currentValue) ₽"
        
        if currentValue >= maxValue && maxValue > 0 {
            self.categoryNameLabel.textColor = .mainRed
        }
        
        config()
    }
    
    init() {
        super.init(frame: .zero)
        
        categoryNameLabel.text = ""
        budgetLabel.text = "0 ₽"
        spentMoneyLabel.text = "0 ₽"
        
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
