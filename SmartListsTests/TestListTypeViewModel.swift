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
    
    func testFetchLists() {
        var lists = listTypeViewModel.fetchLists()
        XCTAssertTrue(lists.isEmpty)
        let newList = listTypeViewModel.addList(title: "Title", type: "Stepper List")
        lists = listTypeViewModel.fetchLists()
        XCTAssertFalse(lists.isEmpty)
        XCTAssertTrue(lists.first == newList)
    }
    
    func testAddList() {
        let newList = listTypeViewModel.addList(title: "Title", type: "Stepper List")
        XCTAssertNotNil(newList, "List should not be nil")
        XCTAssertEqual("Title", newList.title, "List should have the same title")
        XCTAssertTrue(newList.type == "Stepper List", "List should have the same list type")
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
