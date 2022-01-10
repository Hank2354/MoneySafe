//
//  NewWalletUITextFieldDelegate.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 02.01.2022.
//

import Foundation
import UIKit

extension NewWalletViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        // Get text from textField
        let text = textField.text! as NSString

        // Get the text that should be obtained after adding changes by the user
        let updatedText = text.replacingCharacters(in: range, with: string)
        
        if textField.tag == 1 {
            
            // No more 11 characters in field
            guard updatedText.count <= 13 else { return false }
                
            // Set in textField new updated value (with MoneyStyle)
            textField.text = updatedText.applyMoneyStylePattern()
                
            // Move cursor 2 position on the left of the current cursor position
            if let selectedRange = textField.selectedTextRange,
                let newPosition = textField.position(from: selectedRange.start, offset: -2) {
                
                    textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
                
            }
            
        }
        
        if textField.tag == 2 {
            
            // No more 11 characters in field
            guard updatedText.count <= 30 else { return false }
            
            return true
            
        }
        
        return false
    }
    
}
