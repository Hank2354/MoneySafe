//
//  Extension UITextField.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 30.12.2021.
//

import Foundation
import UIKit

extension UITextField {
    
    func addDoneCancelToolBar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any, action: Selector)? = nil) {
        let onCancel = onCancel ?? (target: self, action: #selector(cancelButtonTapped))
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))
        
        let toolBar: UIToolbar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.items = [
            UIBarButtonItem(title: "Cancel", style: .plain, target: onCancel.target, action: onCancel.action),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: onDone.target, action: onDone.action)
            
        ]
        toolBar.sizeToFit()
        
        self.inputAccessoryView = toolBar
    }
    
    func addDoneToolBar(onDone: (target: Any, action: Selector)? = nil) {
        
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))
        
        let toolBar: UIToolbar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: onDone.target, action: onDone.action)
        ]
        
        toolBar.sizeToFit()
        
        self.inputAccessoryView = toolBar
    }
    
    @objc func doneButtonTapped() {
        
        self.resignFirstResponder()
        
    }
    @objc func cancelButtonTapped() {
        
        self.resignFirstResponder()
        
    }
    
}
