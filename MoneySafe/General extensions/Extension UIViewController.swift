//
//  Extension UIViewController.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 28.12.2021.
//

import Foundation
import UIKit

extension UIViewController {
    
    @objc func tapGestureDone() {
        self.view.endEditing(true)
    }
    
    func enableEndEditingModeWithTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureDone))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    
    
}
