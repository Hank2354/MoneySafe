//
//  BudgetTextField.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 24.12.2021.
//

import UIKit

class BudgetTextField: UITextField {

    // MARK: - Properties
    var categoryID: String = ""
    
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    // MARK: - Configuration methods
    func configure(id: String) {
        
        categoryID = id
        
        self.backgroundColor = .white
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lazyGray.cgColor
        self.layer.cornerRadius = 24
        
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    // MARK: - INIT
    init(categoryID: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        configure(id: categoryID)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
