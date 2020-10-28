//
//  ExpenseEditingViewModel.swift
//  expences-app-swiftui
//
//  Created by Serhii Prykhodko on 26.10.2020.
//

import Foundation

class ExpenseEditingViewModel: ObservableObject {
    
    @Published var expense: Expense?
    @Published var name: String = ""
    @Published var amount: String = ""
    @Published var expensesStore: ExpensesStore
    @Published var personIndex: Int
    @Published var dayIndex: Int
    @Published var positionIndex: Int
    @Published var showAlert: Bool
    @Published var navigationText = ""
    @Published var actionButtonText = ""
    
    init(expensesStore: ExpensesStore, expense: Expense, personIndex: Int, dayIndex: Int, positionIndex: Int, showAlert: Bool) {
        self.expensesStore = expensesStore
        self.expense = expense
        self.personIndex = personIndex
        self.dayIndex = dayIndex
        self.positionIndex = positionIndex
        self.showAlert = showAlert
    }
    
    public func handleExpense(operation: OperationType) {
        let enteredAmount = checkEnteredValue(value: amount)
        guard let amountValue = enteredAmount else {
            amount = ""
            showAlert = true
            
            return
        }
        let expense = Expense(name: name, amount: amountValue)
        
        switch operation {
        case .create:
            expensesStore.addExpense(personIndex: personIndex, dayIndex: dayIndex, expense: expense)
        case .update:
            expensesStore.updateExpense(personIndex: personIndex, dayIndex: dayIndex, positionIndex: positionIndex, expense: expense)
        }
        
        self.expense = nil
    }
    
    public func checkEnteredValue(value: String) -> Double? {
        let doubleValue = Double(value)
        
        return doubleValue
    }
    
    public func checkTranferedExpense() {
        guard let expense = expense else { return }
        name = expense.name
        amount = String(format: "%.2f", expense.amount)
        
    }
    
    public func checkOperationType(operation: OperationType) {
        switch operation {
        case .create:
            navigationText = "Add New Expense"
            actionButtonText = "Create"
        case .update:
            navigationText = "Update Expense"
            actionButtonText = "Save"
        }
    }
}
