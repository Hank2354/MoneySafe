//
//  UITextFieldDelegate.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 20.12.2021.
//

import Foundation
import UIKit

extension AddWalletViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let textField = textField as? WalletSetupTextField else { return false }

        var validStatus: Bool = false

        // Get text from textField
        let text = textField.text! as NSString

        // Get the text that should be obtained after adding changes by the user
        let updatedText = text.replacingCharacters(in: range, with: string)
        
        if textField.contentType == .objectName {
            guard updatedText.count <= 20 else { return false }
            
            // If textField is empty validStatus set false
            if updatedText == "" {
                validStatus = false
            } else {
                validStatus = true
            }
            
            textField.text = updatedText
        }
        
        if textField.contentType == .countMoney {
            
            // No more 11 characters in field
            guard updatedText.count <= 11 else { return false }
            
            // Set in textField new updated value (with MoneyStyle)
            textField.text = updatedText.applyMoneyStylePattern()
            
            // Move cursor 2 position on the left of the current cursor position
            if let selectedRange = textField.selectedTextRange,
               let newPosition = textField.position(from: selectedRange.start, offset: -2) {
                    textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
            }
            
            // If textField is empty validStatus set false
            if updatedText == " ₽" {
                validStatus = false
            } else {
                validStatus = true
            }
        }

        if validStatus {
            activateContinueButton()
        } else {
            deactivateContinueButton()
        }
        
        return false
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}


