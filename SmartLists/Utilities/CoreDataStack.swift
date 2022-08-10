//
//  CoreDataStack.swift
//  SmartLists
//
//  Created by Fabio Fiorita on 09/08/22.
//

import Foundation
import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()

    let container: NSPersistentCloudKitContainer
    
    init() {
        container = NSPersistentCloudKitContainer(name: "SmartLists")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error)")
            }
        }
        let options = NSPersistentCloudKitContainerSchemaInitializationOptions()
        try? container.initializeCloudKitSchema(options: options)
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
}
