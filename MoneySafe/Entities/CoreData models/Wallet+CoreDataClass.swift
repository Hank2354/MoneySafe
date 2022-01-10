//
//  Wallet+CoreDataClass.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 26.12.2021.
//
//

import Foundation
import CoreData

@objc(Wallet)
public class Wallet: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.shared.entityForName(entityName: "Wallet"),
                  insertInto: CoreDataManager.shared.managedObjectContext)
    }
}
