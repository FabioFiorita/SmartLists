import CoreData
import SmartLists

class TestCoreDataStack {
    static let shared = TestCoreDataStack()

    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "SmartLists")
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [persistentStoreDescription]

        container.loadPersistentStores { _, error in
          if let error = error {
            fatalError("Unresolved error \(error)")
          }
        }
    }
}

