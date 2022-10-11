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
        XCTAssertTrue(lists.isEmpty, "list should start empty")
        let newList = listTypeViewModel.addList(title: "Title", type: "Stepper List")
        lists = listTypeViewModel.fetchLists()
        XCTAssertFalse(lists.isEmpty, "list shouldn't be empty")
        XCTAssertTrue(lists.first == newList, "first item of the list should be the new list created")
    }
    
    func testAddList() {
        let newList = listTypeViewModel.addList(title: "Title", type: "Stepper List")
        XCTAssertNotNil(newList, "List should not be nil")
        XCTAssertEqual("Title", newList.title, "List should have the same title")
        XCTAssertTrue(newList.type == "Stepper List", "List should have the same list type")
    }
    
    func testDeleteList() {
        let newList = listTypeViewModel.addList(title: "Title", type: "Stepper List")
        var lists = listTypeViewModel.fetchLists()
        XCTAssertFalse(lists.isEmpty, "list shouldn't be empty")
        listTypeViewModel.deleteList(list: newList)
        lists = listTypeViewModel.fetchLists()
        XCTAssertTrue(lists.isEmpty, "list should be empty after deletion")
    }
    
    func testUpdateList() {
        let newList = listTypeViewModel.addList(title: "Title", type: "Stepper List")
        let title = "Title2"
        let type = "Checkbox List"
        let updatedList = listTypeViewModel.updateList(title: title, type: type, list: newList)
        XCTAssertEqual(title, updatedList.title, "List should have the same title")
        XCTAssertTrue(updatedList.type == type, "List should have the same list type")
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
