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
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    override func setUp() {
        self.app = XCUIApplication()
        self.app.launch()
    }

    func testButtonTextOnLaunchScreen() throws {
        // Launch the app
        self.setUp()
        
        // Find button by name
        let button = app.buttons["Show Expenses"]
        
        XCTContext.runActivity(named: "Open launch screen") { _ in
            XCTAssertTrue(button.waitForExistence(timeout: 5.0))
            
            // Check that button is presented on the screen
            XCTAssertTrue(self.app.buttons["Show Expenses"].exists, "Button 'Show Expenses' isn't presented on the screen")
        }
    }
    
    func testGoToExpensesScreen() throws {
        // Launch the app
        self.setUp()
        
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
        // Launch the app
        self.setUp()
        
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

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
