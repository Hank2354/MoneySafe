//
//  Extension String.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 19.12.2021.
//

import Foundation

extension String {
    
    // Pattern for create mask of moneyStyle
    func applyMoneyStylePattern() -> String {
        // Create numbers from text
        let pureNumber = self.replacingOccurrences(of: "[^0-9\\,]", with: "", options: .regularExpression)
        
        if pureNumber == "" {
            return pureNumber
        }
        
        return "\(pureNumber) ₽"
    }
    
    func cancelMoneyStylePattern() -> String {
        let defaultNumber = self.replacingOccurrences(of: "[^0-9\\,]", with: "", options: .regularExpression)
        return defaultNumber
    }
    
    func isExpenseCategoryID() -> Bool {
        let regex = "^1_([0-9]{1,3})"
        
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        
        let actualString = self
        
        if predicate.evaluate(with: actualString) {
            return true
        } else {
            return false
        }
    }
}
