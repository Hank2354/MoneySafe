//
//  UserSettings+CoreDataClass.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 26.12.2021.
//
//

import Foundation
import CoreData

@objc(UserSettings)
public class UserSettings: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.shared.entityForName(entityName: "UserSettings"),
                  insertInto: CoreDataManager.shared.managedObjectContext)
    }
}
