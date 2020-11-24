//
//  ExpenseEditingViewModel.swift
//  expences-app-swiftui
//
//  Created by Serhii Prykhodko on 26.10.2020.
//

import Foundation

class ExpenseEditingViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var amount: String = ""
    @Published var expensesStore: ExpensesStore
    @Published var showAlert: Bool = false
    @Published var navigationText = ""
    @Published var actionButtonText = ""
    
    init(expensesStore: ExpensesStore) {
        self.expensesStore = expensesStore
    }
    
    public func handleExpense(operation: OperationType, expense: ExpenseItem?, personIndex: Int, dayIndex: Int, action: () -> Void) {
        let enteredAmount = checkEnteredValue(value: amount)
        guard let amountValue = enteredAmount else {
            amount = ""
            showAlert = true
            
            return
        }
        let expense = ExpenseItem(name: name, amount: amountValue)
        
        switch operation {
        case .create:
            expensesStore.addExpense(name: name, amount: amountValue, personIndex: personIndex, index: dayIndex)
        case .update:
            print("uncomment this code")
//            expensesStore.updateExpense(expense: expense, name: name, amount: amountValue)
        }
        
        action()
    }
    
    public func checkEnteredValue(value: String) -> Double? {
        let doubleValue = Double(value)
        
        return doubleValue
    }
    
    public func checkTranferedExpense(expense: ExpenseItem?) {
        guard let expense = expense else { return }
        name = expense.wrappedName
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
