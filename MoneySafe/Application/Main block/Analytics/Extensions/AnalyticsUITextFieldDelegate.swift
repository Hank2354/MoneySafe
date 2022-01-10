//
//  AnalyticsUITextFieldDelegate.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 06.01.2022.
//

import Foundation
import UIKit

extension AnalyticsViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
}
