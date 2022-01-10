//
//  BudgetUnit+CoreDataProperties.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 26.12.2021.
//
//

import Foundation
import CoreData


extension BudgetUnit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BudgetUnit> {
        return NSFetchRequest<BudgetUnit>(entityName: "BudgetUnit")
    }

    @NSManaged public var categoryID: String?
    @NSManaged public var budget: NSDecimalNumber?
    @NSManaged public var user: UserSettings?

}

extension BudgetUnit : Identifiable {

}
