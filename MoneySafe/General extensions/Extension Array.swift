//
//  Extension Array.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 22.12.2021.
//

import Foundation

extension Array {
    
    func split() -> [[Element]] {
        let countElements = self.count
        let half = countElements / 2
        let leftSplit = self[0 ..< half]
        let rightSplit = self[half ..< countElements]
        
        return [Array(leftSplit), Array(rightSplit)]
    }
}
