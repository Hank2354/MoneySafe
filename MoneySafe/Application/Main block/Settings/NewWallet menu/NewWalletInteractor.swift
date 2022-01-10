//
//  NewWalletInteractor.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 02.01.2022.
//

import Foundation

class NewWalletInteractor: NewWalletInteractorType {
    
    var presenter: NewWalletPresenterType?
    
    var coreDataManager = CoreDataManager.shared
    
    func saveWallet(walletName: String, startBalance: Decimal) -> Result<String, Errors> {
        
        let allUserWallets = coreDataManager.getUserWallets()
        
        switch allUserWallets {
            
        case .success(let wallets):
            
            var walletNameIsTaken: Bool = false
            
            for userWallet in wallets {
                
                guard userWallet.isActive else { continue }
                
                if userWallet.walletName! == walletName {
                    walletNameIsTaken = true
                }
                
            }
            
            switch walletNameIsTaken {
                
            case true:
                
                return .failure(Errors.incorrectWalletName)
                
            case false:
                
                let newWallet = Wallet()
                newWallet.isActive = true
                newWallet.walletName = walletName
                newWallet.balance = startBalance.round() as NSDecimalNumber
                
                let userSettings = coreDataManager.getUserSettings()
                
                switch userSettings {
                    
                case .success(let userSettings):
                    
                    newWallet.user = userSettings
                    userSettings.addToWallets(newWallet)
                    
                    coreDataManager.saveContext()
                    
                    return .success("OK")
                    
                case .failure(let error):
                    
                    return .failure(error)
                    
                }
                
            }
            
        case .failure(let error):
            
            return .failure(error)
            
        }
        
    }
    
    
}
