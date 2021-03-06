//
//  expences_app_swiftuiUITests.swift
//  expences-app-swiftuiUITests
//
//  Created by Serhii Prykhodko on 08.10.2020.
//

import XCTest

class expences_app_swiftuiUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    override func setUp() {
        self.app = XCUIApplication()
        self.app.launch()
    }
    
    func testButtonTextOnLaunchScreen() throws {
        // Find button by name
        let button = app.buttons["Show Expenses"]
        
        XCTContext.runActivity(named: "Open launch screen") { _ in
            XCTAssertTrue(button.waitForExistence(timeout: 5.0))
            
            // Check that button is presented on the screen
            XCTAssertTrue(self.app.buttons["Show Expenses"].exists, "Button 'Show Expenses' isn't presented on the screen")
        }
    }
    
    func testGoToExpensesScreen() throws {
        // Find button by name
        let button = app.buttons["Show Expenses"]
        
        XCTContext.runActivity(named: "Open launch screen") { _ in
            XCTAssertTrue(button.waitForExistence(timeout: 5.0))
            
            // Open expenses screen
            button.tap()
            
            // Check screen navigation title text
            XCTAssertTrue(app.navigationBars.staticTexts["Expenses"].waitForExistence(timeout: 5.0), "Can't find text 'Expenses' on the navigation bar")
        }
    }
    
    func testCheckExpensesData() throws {
        // Find button by name
        let button = app.buttons["Show Expenses"]
        
        XCTContext.runActivity(named: "Open launch screen") { _ in
            XCTAssertTrue(button.waitForExistence(timeout: 5.0))
            
            // Open expenses screen
            button.tap()
            
            // Check first expense title and price
            XCTAssertTrue(app.cells.staticTexts["Beer"].waitForExistence(timeout: 5.0), "Can't find data 'Beer' on the screen")
            XCTAssertTrue(app.cells.staticTexts["$ 19.00"].waitForExistence(timeout: 5.0), "Can't find data '19.00' on the screen")
        }
    }
    
    func testCallWindowForNewExpense() throws {
        
        // Find button by name
        let button = app.buttons["Show Expenses"]
        
        XCTContext.runActivity(named: "Open launch screen") { _ in
            XCTAssertTrue(button.waitForExistence(timeout: 5.0))
            
            // Open expenses screen
            button.tap()
            
            // Find first plus button and tap on it
            app.cells.buttons["plus"].firstMatch.tap()
            
            // Check that new window is appeared
            XCTAssertTrue(app.navigationBars.staticTexts["Add New Expense"].waitForExistence(timeout: 5.0))
        }
    }
    
    func testCreateNewExpense() throws {
        
        // Find button by name
        let button = app.buttons["Show Expenses"]
        
        XCTContext.runActivity(named: "Open launch screen") { _ in
            XCTAssertTrue(button.waitForExistence(timeout: 5.0))
            
            // Open expenses screen
            button.tap()
            
            // Find first plus button and tap on it
            app.cells.buttons["plus"].firstMatch.tap()
            
            let nameTextField = app.textFields["Enter name here"]
            nameTextField.tap()
            
            // Enter name for future expense
            nameTextField.typeText("New test expense")
            
            let amountTextField = app.textFields["Enter amount here"]
            amountTextField.tap()
            
            // Enter amount for future expense
            amountTextField.clearAndEnterText(text: "123.45")
            
            // Save new expense
            let createButton = app.buttons["Create"]
            createButton.tap()
            
            // Check created expense in list
            XCTAssertTrue(app.cells.staticTexts["New test expense"].waitForExistence(timeout: 5.0), "Can't find new expense 'New test expense' on the screen")
            XCTAssertTrue(app.cells.staticTexts["$ 123.45"].waitForExistence(timeout: 5.0), "Can't find new expense amount '123.45' on the screen")
        }
    }
    
    func testEditAndDeleteExpense() throws {
        
        // Find button by name
        let button = app.buttons["Show Expenses"]
        
        XCTContext.runActivity(named: "Open launch screen") { _ in
            XCTAssertTrue(button.waitForExistence(timeout: 5.0))
            
            // Open expenses screen
            button.tap()
            
            // Create property with all cells
            let tableCells = app.tables.cells
            
            // Tap on first cell with expense
            tableCells.element(boundBy: 1).tap()
            
            // Change epxense details
            let nameTextField = app.textFields["Enter name here"]
            nameTextField.tap()
            nameTextField.clearAndEnterText(text: "Edited test expense")
            
            let amountTextField = app.textFields["Enter amount here"]
            amountTextField.tap()
            amountTextField.clearAndEnterText(text: "43.21")
            
            // Save new expense
            let createButton = app.buttons["Save"]
            createButton.tap()
            
            // Find first cell swipe and delete it
            tableCells.element(boundBy: 1).swipeLeft()
            tableCells.element(boundBy: 1).buttons["Delete"].tap()
            
            // Check created expense in list
            XCTAssertFalse(app.cells.staticTexts["Edited test expense"].waitForExistence(timeout: 5.0), "Deleted expense name is still appeared on the screen")
            XCTAssertFalse(app.cells.staticTexts["$ 43.21"].waitForExistence(timeout: 5.0), "Deleted expense amount is still appeared on the screen")
        }
    }
    
    func testGoToPeopleList() throws {
        // Find button by name
        let button = app.buttons["Show People"]
        
        XCTContext.runActivity(named: "Open launch screen") { _ in
            XCTAssertTrue(button.waitForExistence(timeout: 5.0))
            
            // Open expenses screen
            button.tap()
            
            // Check screen navigation title text
            XCTAssertTrue(app.navigationBars.staticTexts["People"].waitForExistence(timeout: 5.0), "Can't find text 'Expenses' on the navigation bar")
        }
    }
// THIS TEST IS COMMENTED TILL IT IS NOT FIXED
//    func testCreateNewPerson() throws {
//        // Find button by name
//        let button = app.buttons["Show People"]
//
//        XCTContext.runActivity(named: "Open launch screen") { _ in
//            XCTAssertTrue(button.waitForExistence(timeout: 5.0))
//
//            // Open expenses screen
//            button.tap()
//
//            // Find edit button and tap on it
//            let editButton = app.navigationBars.buttons["Edit"]
//            editButton.tap()
//
//            // Find plus button and tap on it
//            let plusButton = app.navigationBars.buttons["plus"]
//            plusButton.tap()
//
//            // Find text field on the screen
//            let nameTextField = app.textFields["Enter name here"]
//            nameTextField.tap()
//
//            // Enter name for future expense
//            nameTextField.typeText("New test person")
//
//            // Save new expense
//            let createButton = app.buttons["Create"]
//            createButton.tap()
//
//            // Find done button and tap on it
//            let doneButton = app.navigationBars.buttons["Done"]
//            doneButton.tap()
//
//            // Check created expense in list
//            XCTAssertTrue(app.cells.staticTexts["New test person"].waitForExistence(timeout: 5.0), "Can't find new person 'New test person' on the screen")
//        }
//    }
}

extension XCUIElement {
    /**
     Removes any current text in the field before typing in the new value
     - Parameter text: the text to enter into the field
     */
    func clearAndEnterText(text: String) {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }

        tap()

        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)

        typeText(deleteString)
        typeText(text)
    }
}
