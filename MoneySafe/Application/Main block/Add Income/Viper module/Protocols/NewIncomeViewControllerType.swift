//
//  NewIncomeViewControllerType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 28.12.2021.
//

import Foundation
import UIKit

protocol NewIncomeViewControllerType {
    
    var presenter: NewIncomePresenterType? { get set }
    
    var categoryViews: [CategoryView] { get set }
    
    var walletViews: [WalletView] { get set }
    
    var amountTextField: UITextField { get set }
    
    var desctiptionTextField: UITextField { get set }
    
    func update(with wallets: [GeneralWalletModel])
    
    func update(with categories: [GeneralCategoryModel])
    
    func presentWarnMessage(alertController: UIAlertController)
    
}
