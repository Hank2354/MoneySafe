//
//  BudgetUnit+CoreDataClass.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 26.12.2021.
//
//

import Foundation
import CoreData

@objc(BudgetUnit)
public class BudgetUnit: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.shared.entityForName(entityName: "BudgetUnit"),
                  insertInto: CoreDataManager.shared.managedObjectContext)
    }
}
