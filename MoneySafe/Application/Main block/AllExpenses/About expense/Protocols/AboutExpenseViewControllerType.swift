//
//  AboutExpenseViewControllerType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 01.01.2022.
//

import Foundation
import UIKit

protocol AboutExpenseViewControllerType {
    
    var presenter: AboutExpensePresenterType? { get set }
    
    var categoryViews: [CategoryView] { get set }
    
    var walletViews: [WalletView] { get set }
    
    var amountTextField: UITextField { get set }

    var desctiptionTextField: UITextField { get set }
    
    var datePickerView: UIDatePicker { get set }
    
    var walletsCollectionView: UICollectionView { get set }
    
    var categoriesCollectionView: UICollectionView { get set }

    func update(with wallets: [GeneralWalletModel])

    func update(with categories: [GeneralCategoryModel])
    
    func update(with transactionAmount: Decimal, descriptionText: String, date: Date)

    func presentWarnMessage(alertController: UIAlertController)
}
