//
//  ObjectViewModel.swift
//  SmartLists
//
//  Created by Fabio Fiorita on 08/08/22.
//

import Foundation
import CoreData

final class ObjectViewModel: ObservableObject {
    @Published var objects: [ObjectEntity] = []
    let container: NSPersistentCloudKitContainer
    
    init() {
           container = NSPersistentCloudKitContainer(name: "SmartLists")
           container.loadPersistentStores { description, error in
               if let error = error {
                   print("ERROR LOADING CORE DATA. \(error)")
               }
           }
           //let options = NSPersistentCloudKitContainerSchemaInitializationOptions()
           //try? container.initializeCloudKitSchema(options: options)
           container.viewContext.automaticallyMergesChangesFromParent = true
           container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        fetchObjects()
       }
    
    private func saveData() {
        do {
            try container.viewContext.save()
            fetchObjects()
        } catch {
            print("Error saving. \(error)")
        }
    }
    
    func fetchObjects() {
        let request = NSFetchRequest<ObjectEntity>(entityName: "ObjectEntity")
        do {
            objects = try container.viewContext.fetch(request)
        } catch {
            print("Error Fetching. \(error)")
        }
    }
    
    func addObject(content: String) {
        let newObject = ObjectEntity(context: container.viewContext)
        newObject.content = content
        newObject.amount = 0
        saveData()
    }
    
    func increaseAmount(object: ObjectEntity) {
        object.amount = object.amount + 1
        print(object.amount)
        saveData()
    }
    
    func decreaseAmount(object: ObjectEntity) {
        object.amount = object.amount - 1
        saveData()
    }
    
    func deleteObject() {
        
    }
    
    func updateObject() {
        
    }
}
