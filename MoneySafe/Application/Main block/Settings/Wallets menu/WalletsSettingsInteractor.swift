//
//  WalletsSettingsInteractor.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 01.01.2022.
//

import Foundation

class WalletsSettingsInteractor: WalletsSettingsInteractorType {
    
    var presenter: WalletsSettingsPresenterType?
    
    let coreDataManager = CoreDataManager.shared
    
    func fetchUserWalletsWithCurrentBalance() {
        
        let wallets = coreDataManager.getUserWallets()
        
        switch wallets {
            
        case .success(let wallets):
            
            var currentWallets = [GeneralWalletModel]()
            
            for wallet in wallets {
                
                guard wallet.isActive else { continue }
                
                let transactions = coreDataManager.getTransactionsForWallet(wallet: wallet)
                
                switch transactions {
                    
                case .success(let transactions):
                    
                    var walletBalance = wallet.balance! as Decimal
                    
                    for transaction in transactions {
                        
                        if transaction.categoryID!.isExpenseCategoryID() {
                            walletBalance -= transaction.amount! as Decimal
                        } else {
                            walletBalance += transaction.amount! as Decimal
                        }
                        
                    }
                    
                    currentWallets.append(GeneralWalletModel(walletName: wallet.walletName!,
                                                             icon: nil,
                                                             balance: walletBalance,
                                                             walletMO: wallet))
                    
                case .failure(let error):
                    print(error)
                    return
                    
                }
                
            }
            
            presenter?.isWalletsDataFetched(walletModels: currentWallets)
            
        case .failure(let error):
            
            print(error)
            return
            
        }
        
    }
    
    func disactiveWallet(wallet: Wallet) {
        
        wallet.isActive = false
        
        coreDataManager.saveContext()
        
    }
    
    func changeWalletName(wallet: Wallet, newName: String) -> Result<Any, Errors> {
        
        let allUserWallets = coreDataManager.getUserWallets()
        
        switch allUserWallets {
            
        case .success(let wallets):
            
            var walletNameIsTaken: Bool = false
            
            for userWallet in wallets {
                
                guard userWallet.isActive else { continue }
                
                if userWallet.walletName! == newName {
                    walletNameIsTaken = true
                }
                
            }
            
            switch walletNameIsTaken {
                
            case true:
                
                return .failure(Errors.incorrectWalletName)
                
            case false:
                
                wallet.walletName = newName
                coreDataManager.saveContext()
                return .success("OK")
                
            }
            
        case .failure(let error):
            
            return .failure(error)
            
        }
        
    }
    
    
}
