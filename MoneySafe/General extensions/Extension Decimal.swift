//
//  Extension Decimal.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 01.01.2022.
//

import Foundation

extension Decimal {
    
    func round() -> Decimal {
        
        var value = self
        var result = Decimal()
        
        NSDecimalRound(&result, &value, 2, .plain)
        
        return result
        
    }
}
