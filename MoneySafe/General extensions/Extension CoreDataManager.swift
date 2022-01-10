//
//  CoreDataManager.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 27.12.2021.
//

import Foundation
import CoreData

extension CoreDataManager {
    
    func getUserSettings() -> Result<UserSettings, Errors> {
        let fetchRequest: NSFetchRequest<UserSettings> = UserSettings.fetchRequest()
        
        do {
            let result = try managedObjectContext.fetch(fetchRequest)
            guard let currentUserSettings = result.first else { return .failure(Errors.loadUserSettingsError) }
            return .success(currentUserSettings)
        } catch {
            return .failure(Errors.loadUserSettingsError)
        }
    }
    
    func getUserWallets() -> Result<[Wallet], Errors> {
        
        let userSettings = getUserSettings()
        
        switch userSettings {
            
        case.success(let userSettings):
            
            let wallets = userSettings.wallets?.allObjects as? [Wallet]
            
            guard let wallets = wallets else { return .failure(Errors.loadWalletsError) }
            
            return .success(wallets)
            
        case .failure(let error):
            
            return .failure(error)
            
        }
        
    }
    
    func getUserBudgetUnits() -> Result<[BudgetUnit], Errors> {
        
        let userSettings = getUserSettings()
        
        switch userSettings {
            
        case.success(let userSettings):
            
            let budgetUnits = userSettings.budgetUnits?.allObjects as? [BudgetUnit]
            
            guard let budgetUnits = budgetUnits else { return .failure(Errors.loadUserBudgetsError) }
            
            return .success(budgetUnits)
            
        case .failure(let error):
            
            return .failure(error)
            
        }
        
    }
    
    func getAllTransactions() -> Result<[Transaction], Errors> {
        
        var transactions = [Transaction]()
        
        let wallets = getUserWallets()
        
        switch wallets {
            
        case .success(let wallets):
            
            for wallet in wallets {
                
                let walletTransactions = wallet.transactions?.allObjects as? [Transaction]
                
                guard let walletTransactions = walletTransactions else { return .failure(Errors.loadTransactionsError) }
                
                for walletTransaction in walletTransactions {
                    transactions.append(walletTransaction)
                }
            }
            
            return .success(transactions)
            
        case.failure(let error):
            
            return .failure(error)
            
        }
        
    }
    
    func getTransactionsForWallet(wallet: Wallet) -> Result<[Transaction], Errors> {
        
        let userWallets = getUserWallets()
        let currentWalletName = wallet.walletName ?? ""
        
        var transactions = [Transaction]()
        
        switch userWallets {
            
        case .success(let wallets):
            
            for userWallet in wallets  {
                if let userWalletName = userWallet.walletName,
                   userWalletName == currentWalletName {
                    
                    let walletTransactions = userWallet.transactions?.allObjects as? [Transaction]
                    
                    guard let walletTransactions = walletTransactions else { return .failure(Errors.loadTransactionsError) }
                    
                    transactions = walletTransactions
                    
                }
                
            }
            
            return .success(transactions)
            
        case .failure(let error):
            
            return .failure(error)
            
        }
        
        
        
    }
    
    func deleteTransaction(_ transaction: Transaction) {
        
        let currentWallet = transaction.wallet!
        
        currentWallet.removeFromTransactions(transaction)
        
        managedObjectContext.delete(transaction)
        
        saveContext()
        
    }
    
    
}
