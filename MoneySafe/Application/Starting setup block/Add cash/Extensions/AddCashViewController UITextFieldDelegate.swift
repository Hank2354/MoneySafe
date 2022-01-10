//
//  extf.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 19.12.2021.
//

import Foundation
import UIKit

extension AddCashViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        var validStatus: Bool = false

        // Get text from textField
        let text = textField.text! as NSString

        // Get the text that should be obtained after adding changes by the user
        let updatedText = text.replacingCharacters(in: range, with: string)

        if updatedText.count >= 11 {
            return false
        }

        // Set in textField new updated value (with MoneyStyle)
        textField.text = updatedText.applyMoneyStylePattern()

        // Move cursor 2 position on the left of the current cursor position
        if let selectedRange = textField.selectedTextRange {
            if let newPosition = textField.position(from: selectedRange.start, offset: -2) {
                textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
            }
        }

        if updatedText == " ₽" {
            validStatus = false
        } else {
            validStatus = true
        }

        if validStatus {
            activateContinueButton()
        } else {
            deactivateContinueButton()
        }
        return false
    }

}
    
