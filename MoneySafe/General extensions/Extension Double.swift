//
//  Extension Double.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 23.01.2022.
//

import Foundation

extension Double {
    
    func roundToPlaces(_ place: Int) -> Double {
        let divisor = pow(10.0, Double(place))
        return (self * divisor).rounded() / divisor
        
    }
}
