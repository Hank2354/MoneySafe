//
//  Extension UINavigationController.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 31.12.2021.
//

import Foundation
import UIKit

extension UINavigationController {
    
    func setNavBarStyle(color: UIColor) {
        
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let navBarPreset = UINavigationBarAppearance()
        navBarPreset.backgroundColor = color
        navBarPreset.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        self.navigationBar.standardAppearance = navBarPreset
        self.navigationBar.scrollEdgeAppearance = navBarPreset
        
    }
}
