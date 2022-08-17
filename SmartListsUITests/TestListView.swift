//
//  TestListView.swift
//  SmartListsUITests
//
//  Created by Fabio Fiorita on 15/08/22.
//

import XCTest

final class TestListView: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        app.launch()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        
    }

    func testNewItemButton() {
        app.toolbars["Toolbar"]/*@START_MENU_TOKEN@*/.buttons["New list"]/*[[".otherElements[\"New list\"].buttons[\"New list\"]",".buttons[\"New list\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let newItemModal = app.navigationBars["New list"]
        XCTAssert(newItemModal.exists)
    }
}
