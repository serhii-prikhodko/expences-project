//
//  expences_app_swiftuiTests.swift
//  expences-app-swiftuiTests
//
//  Created by Serhii Prykhodko on 08.10.2020.
//

import XCTest
@testable import expences_app_swiftui

class ExpenseEditingViewModelUnitTests: XCTestCase {
    
    var viewModel: ExpenseEditingViewModel!
    var expensesStore: ExpensesStore!

    override func setUpWithError() throws {
        super.setUp()
        expensesStore = ExpensesStore()
        viewModel = ExpenseEditingViewModel(expensesStore: expensesStore)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        expensesStore = nil
        super.tearDown()
    }
    
    func test_positive_func_checkEnteredValue() {
        let value = viewModel.checkEnteredValue(value: "2.00")
        
        XCTAssertEqual(value, 2.00)
    }
    
    func test_negative_func_checkEnteredValue() {
        let value = viewModel.checkEnteredValue(value: "abc")
        
        XCTAssertEqual(value, nil)
    }
    
    func test_positive_func_checkTranferedExpense() {
        let expense = Expense(name: "Test item", amount: 1.22)
        viewModel.checkTranferedExpense(expense: expense)
        
        XCTAssertEqual(viewModel.name, "Test item")
        XCTAssertEqual(viewModel.amount, "1.22")
    }
    
    func test_negative_func_checkTranferedExpense() {
        let expense: Expense? = nil
        viewModel.checkTranferedExpense(expense: expense)
        
        XCTAssertEqual(viewModel.name, "")
        XCTAssertEqual(viewModel.amount, "")
    }
    
    func test_func_checkOperationType_update() {
        viewModel.checkOperationType(operation: .update)
        
        XCTAssertEqual(viewModel.navigationText, "Update Expense")
        XCTAssertEqual(viewModel.actionButtonText, "Save")
    }
    
    func test_func_checkOperationType_create() {
        viewModel.checkOperationType(operation: .create)
        
        XCTAssertEqual(viewModel.navigationText, "Add New Expense")
        XCTAssertEqual(viewModel.actionButtonText, "Create")
    }
    
    func test_func_handleExpense_create() {
        viewModel.name = "New item"
        viewModel.amount = "2.25"
        viewModel.handleExpense(operation: .create, personIndex: 0, dayIndex: 0, positionIndex: 0)
        let createdExpense = viewModel.expensesStore.expenses[0].weeklyExpenses[0].dailyExpenses.last
        
        XCTAssertEqual(createdExpense?.name, "New item")
        XCTAssertEqual(createdExpense?.amount, 2.25)
    }
    
    func test_func_handleExpense_update() {
        viewModel.name = "Updated item"
        viewModel.amount = "2.25"
        viewModel.handleExpense(operation: .update, personIndex: 0, dayIndex: 0, positionIndex: 0)
        let createdExpense = viewModel.expensesStore.expenses[0].weeklyExpenses[0].dailyExpenses[0]
        
        XCTAssertEqual(createdExpense.name, "Updated item")
        XCTAssertEqual(createdExpense.amount, 2.25)
    }
}
