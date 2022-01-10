//
//  UserSettings+CoreDataProperties.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 26.12.2021.
//
//

import Foundation
import CoreData


extension UserSettings {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserSettings> {
        return NSFetchRequest<UserSettings>(entityName: "UserSettings")
    }

    @NSManaged public var incomeCategoriesID: [String]?
    @NSManaged public var expenseCategoriesID: [String]?
    @NSManaged public var wallets: NSSet?
    @NSManaged public var budgetUnits: NSSet?

}

// MARK: Generated accessors for wallets
extension UserSettings {

    @objc(addWalletsObject:)
    @NSManaged public func addToWallets(_ value: Wallet)

    @objc(removeWalletsObject:)
    @NSManaged public func removeFromWallets(_ value: Wallet)

    @objc(addWallets:)
    @NSManaged public func addToWallets(_ values: NSSet)

    @objc(removeWallets:)
    @NSManaged public func removeFromWallets(_ values: NSSet)

}

// MARK: Generated accessors for budgetUnits
extension UserSettings {

    @objc(addBudgetUnitsObject:)
    @NSManaged public func addToBudgetUnits(_ value: BudgetUnit)

    @objc(removeBudgetUnitsObject:)
    @NSManaged public func removeFromBudgetUnits(_ value: BudgetUnit)

    @objc(addBudgetUnits:)
    @NSManaged public func addToBudgetUnits(_ values: NSSet)

    @objc(removeBudgetUnits:)
    @NSManaged public func removeFromBudgetUnits(_ values: NSSet)

}

extension UserSettings : Identifiable {

}
