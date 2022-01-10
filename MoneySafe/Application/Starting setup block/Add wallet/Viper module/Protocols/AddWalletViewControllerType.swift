//
//  AddWalletViewControllerType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 19.12.2021.
//

import Foundation
import UIKit

protocol AddWalletViewControllerType {
    
    var presenter: AddWalletPresenterType? { get set }
    
    var moneyCountTextField: UITextField { get set }
    
    var walletNameTextField: UITextField { get set }
    
    func saveWallet()
    
    func skipAddingWallet()
    
    func backAction()
    
    func presentWarnMessage(with text: String)
}
