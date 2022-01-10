//
//  AddCashViewType.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 19.12.2021.
//

import Foundation
import UIKit

protocol AddCashViewControllerType {
    
    var presenter: AddCashPresenterType? { get set }
    
    var moneyTextField: UITextField { get set }
    
    func saveCashCount()
    
    func skipCash()
}
