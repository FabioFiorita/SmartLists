//
//  TestObjectViewModel.swift
//  SmartListsTests
//
//  Created by Fabio Fiorita on 09/08/22.
//

import XCTest
@testable import SmartLists
import CoreData

final class TestStepperItemViewModel: XCTestCase {
    
    var viewContext: NSManagedObjectContext!
    var stepperItemViewModel: StepperItemViewModel!
    var listType: ListType!
    
    override func setUp() {
        super.setUp()
        self.viewContext = TestCoreDataStack.shared.container.viewContext
        self.stepperItemViewModel = StepperItemViewModel(viewContext: viewContext)
        addListType(viewContext: viewContext)
    }
    
    override func tearDown() {
        flushData(viewContext: viewContext)
        flushList(viewContext: viewContext)
        self.viewContext = nil
        self.stepperItemViewModel = nil
        super.tearDown()
    }
    
    func testFetchItems() {
        var items = stepperItemViewModel.fetchItems()
        XCTAssertTrue(items.isEmpty)
        let newItem = stepperItemViewModel.addItem(content: "Test", listType: listType)
        items = stepperItemViewModel.fetchItems()
        XCTAssertFalse(items.isEmpty)
        XCTAssertTrue(items.first == newItem)
    }

    func testAddItem() {
        let newItem = stepperItemViewModel.addItem(content: "Test", listType: listType)
        XCTAssertNotNil(newItem, "Item should not be nil")
        XCTAssertEqual("Test", newItem.content, "Item should have the same content")
        XCTAssertTrue(newItem.listType == listType, "Item should have the same list type")
        XCTAssertTrue(newItem.amount == 0, "Item should have amount == 0")
    }
    
    func testIncreaseAmount() {
        let newItem = stepperItemViewModel.addItem(content: "Test", listType: listType)
        XCTAssertTrue(newItem.amount == 0, "Item should have amount == 0")
        let resItem = stepperItemViewModel.increaseAmount(item: newItem)
        XCTAssertEqual(1, resItem.amount, "Item should have amount == 1 after increasing amount")
    }
    
    func testDecreaseAmount() {
        let newItem = stepperItemViewModel.addItem(content: "Test", listType: listType)
        newItem.amount = 3
        XCTAssertEqual(3, newItem.amount, "Item should have amount == 3")
        let resItem = stepperItemViewModel.decreaseAmount(item: newItem)
        XCTAssertEqual(2, resItem.amount, "Item should have amount == 2 after decreasing amount")
    }
    
    func testDeleteItem() {
        let fetchRequest: NSFetchRequest<StepperItem> = StepperItem.fetchRequest()
        var resItems = try! viewContext.fetch(fetchRequest)
        XCTAssertTrue(resItems.isEmpty, "FetchRequest should return an empty array")
        
        let newItem = stepperItemViewModel.addItem(content: "Test", listType: listType)
        resItems = try! viewContext.fetch(fetchRequest)
        XCTAssertFalse(resItems.isEmpty, "FetchRequest should return an array with elements")
        XCTAssertEqual(newItem, resItems.first, "The first item in the array should be the same as the new item created")
        
        stepperItemViewModel.deleteItem(item: newItem)
        resItems = try! viewContext.fetch(fetchRequest)
        XCTAssertTrue(resItems.isEmpty, "FetchRequest should return an empty array after deletion")
    }
    
    func testUpdateItem() {
        let newItem = stepperItemViewModel.addItem(content: "Test", listType: listType)
        let content = newItem.content
        let modifiedItem = stepperItemViewModel.updateItem(item: newItem, newContent: "Test2")
        XCTAssertEqual(newItem.id, modifiedItem.id, "Modified item should have the same id as the new item created")
        XCTAssertNotEqual(content, modifiedItem.content, "Modified item should have a different content as the new item created")
    }

}

extension TestStepperItemViewModel {
    func flushData(viewContext: NSManagedObjectContext) {
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "StepperItem")
        let items = try! viewContext.fetch(fetchRequest)
        for case let item as NSManagedObject in items {
            viewContext.delete(item)
        }
        try! viewContext.save()
    }
    func addListType(viewContext: NSManagedObjectContext) {
        listType = ListType(context: viewContext)
        listType.id = UUID()
        listType.title = "Title"
        listType.type = "Stepper List"
        try! viewContext.save()
    }
    func flushList(viewContext: NSManagedObjectContext) {
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "ListType")
        let lists = try! viewContext.fetch(fetchRequest)
        for case let list as NSManagedObject in lists {
            viewContext.delete(list)
        }
        try! viewContext.save()
    }
}
