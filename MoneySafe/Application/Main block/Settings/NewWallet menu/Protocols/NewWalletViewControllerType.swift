//
//  NewWalletViewControllerType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 02.01.2022.
//

import Foundation
import UIKit

protocol NewWalletViewControllerType {
    
    var presenter: NewWalletPresenterType? { get set }
    
    var amountTextField: UITextField { get set }
    
    var desctiptionTextField: UITextField { get set }
    
    func presentWarnMessage(alertController: UIAlertController)
}
