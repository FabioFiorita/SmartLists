//
//  TestListTypeViewModel.swift
//  SmartListsTests
//
//  Created by Fabio Fiorita on 10/08/22.
//

import XCTest
@testable import SmartLists
import CoreData

final class TestListTypeViewModel: XCTestCase {
    var viewContext: NSManagedObjectContext!
    var listTypeViewModel: ListTypeViewModel!
    
    override func setUp() {
        super.setUp()
        self.viewContext = TestCoreDataStack.shared.container.viewContext
        self.listTypeViewModel = ListTypeViewModel(viewContext: viewContext)
    }
    
    override func tearDown() {
        flushData(viewContext: viewContext)
        self.viewContext = nil
        self.listTypeViewModel = nil
        super.tearDown()
    }
    
    

}

extension TestListTypeViewModel {
    func flushData(viewContext: NSManagedObjectContext) {
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "ListType")
        let items = try! viewContext.fetch(fetchRequest)
        for case let item as NSManagedObject in items {
            viewContext.delete(item)
        }
        try! viewContext.save()
    }
}
