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

    func testNewItemModal() {
        let toolbar = app.toolbars["Toolbar"]
        toolbar/*@START_MENU_TOKEN@*/.buttons["New list"]/*[[".otherElements[\"New list\"].buttons[\"New list\"]",".buttons[\"New list\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let navBar = app.navigationBars["New list"]
        XCTAssertTrue(navBar.exists)
        
        let collectionViews = app.collectionViews
        collectionViews/*@START_MENU_TOKEN@*/.textFields["Shopping, reminders, bills..."]/*[[".cells.textFields[\"Shopping, reminders, bills...\"]",".textFields[\"Shopping, reminders, bills...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let keyT = app.keys["T"]
        keyT.tap()
        let keyt = app.keys["t"]
        keyt.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"retorno\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        toolbar/*@START_MENU_TOKEN@*/.buttons["Save"]/*[[".otherElements[\"Save\"].buttons[\"Save\"]",".buttons[\"Save\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssertFalse(navBar.exists)
        
        collectionViews.buttons["Tt"].tap()
        let listNavBar = app.navigationBars["Tt"]
        XCTAssertTrue(listNavBar.exists)
        
        listNavBar.buttons["SmartLists"].tap()
        XCTAssertFalse(listNavBar.exists)
        
        let ttButton = collectionViews/*@START_MENU_TOKEN@*/.buttons["Tt"]/*[[".cells.buttons[\"Tt\"]",".buttons[\"Tt\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        ttButton.swipeLeft()
        collectionViews.buttons["Delete"].tap()
        XCTAssertFalse(ttButton.exists)
                
    }
}
