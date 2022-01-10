//
//  Transaction+CoreDataClass.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 26.12.2021.
//
//

import Foundation
import CoreData

@objc(Transaction)
public class Transaction: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.shared.entityForName(entityName: "Transaction"),
                  insertInto: CoreDataManager.shared.managedObjectContext)
    }
}
