//
//  Extension UIBarButtonItem.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 29.12.2021.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    
    func addTarget(sender: AnyObject?, action: Selector) {
        self.target = sender
        self.action = action
    }
}
