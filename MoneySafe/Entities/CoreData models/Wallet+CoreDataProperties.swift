//
//  Wallet+CoreDataProperties.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 26.12.2021.
//
//

import Foundation
import CoreData


extension Wallet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Wallet> {
        return NSFetchRequest<Wallet>(entityName: "Wallet")
    }

    @NSManaged public var walletName: String?
    @NSManaged public var balance: NSDecimalNumber?
    @NSManaged public var isActive: Bool
    @NSManaged public var user: UserSettings?
    @NSManaged public var transactions: NSSet?

}

// MARK: Generated accessors for transactions
extension Wallet {

    @objc(addTransactionsObject:)
    @NSManaged public func addToTransactions(_ value: Transaction)

    @objc(removeTransactionsObject:)
    @NSManaged public func removeFromTransactions(_ value: Transaction)

    @objc(addTransactions:)
    @NSManaged public func addToTransactions(_ values: NSSet)

    @objc(removeTransactions:)
    @NSManaged public func removeFromTransactions(_ values: NSSet)

}

extension Wallet : Identifiable {

}
