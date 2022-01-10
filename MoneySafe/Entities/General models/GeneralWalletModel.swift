//
//  Wallet.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 20.12.2021.
//

import Foundation
import UIKit

struct GeneralWalletModel {
    let walletName: String
    let icon: UIImage?
    let balance: Decimal
    var walletMO: Wallet? = nil
}
