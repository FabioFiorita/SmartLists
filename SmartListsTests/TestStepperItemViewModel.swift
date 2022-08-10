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
    
    override func setUp() {
        super.setUp()
        self.viewContext = TestCoreDataStack.shared.container.viewContext
        self.stepperItemViewModel = StepperItemViewModel(viewContext: viewContext)
    }
    
    override func tearDown() {
        flushData(viewContext: viewContext)
        self.viewContext = nil
        self.stepperItemViewModel = nil
        super.tearDown()
    }

    func testAddItem() {
        let newItem = stepperItemViewModel.addItem(content: "Test")
        XCTAssertNotNil(newItem, "Object should not be nil")
        XCTAssertEqual("Test", newItem.content)
        XCTAssertTrue(newItem.amount == 0)
        
    }
    
    func testIncreaseAmount() {
        let newItem = stepperItemViewModel.addItem(content: "Test")
        let resItem = stepperItemViewModel.increaseAmount(item: newItem)
        XCTAssertEqual(1, resItem.amount)
    }
    
    func testDecreaseAmount() {
        let newItem = stepperItemViewModel.addItem(content: "Test")
        newItem.amount = 3
        let resItem = stepperItemViewModel.decreaseAmount(item: newItem)
        XCTAssertEqual(2, resItem.amount)
    }
    
    func testDeleteItem() {
        let fetchRequest: NSFetchRequest<StepperItem> = StepperItem.fetchRequest()
        var resItems = try! viewContext.fetch(fetchRequest)
        XCTAssertTrue(resItems.isEmpty)
        
        let newItem = stepperItemViewModel.addItem(content: "Test")
        resItems = try! viewContext.fetch(fetchRequest)
        XCTAssertFalse(resItems.isEmpty)
        XCTAssertEqual(newItem, resItems.first)
        
        stepperItemViewModel.deleteItem(item: newItem)
        resItems = try! viewContext.fetch(fetchRequest)
        XCTAssertTrue(resItems.isEmpty)
    }
    
//    func testUpdateItem() {
//        
//
//    }

}

extension TestStepperItemViewModel {
    func flushData(viewContext: NSManagedObjectContext) {
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "StepperItem")
        let objs = try! viewContext.fetch(fetchRequest)
        for case let obj as NSManagedObject in objs {
            viewContext.delete(obj)
        }
        try! viewContext.save()
    }
}
