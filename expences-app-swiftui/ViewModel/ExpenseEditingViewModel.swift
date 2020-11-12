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
    
    public func handleExpense(operation: OperationType, personIndex: Int, dayIndex: Int, positionIndex: Int, action: () -> Void) {
        let enteredAmount = checkEnteredValue(value: amount)
        guard let amountValue = enteredAmount else {
            amount = ""
            showAlert = true
            
            return
        }
        
        switch operation {
        case .create:
            expensesStore.addExpense(personIndex: personIndex, dayIndex: dayIndex, name: name, amount: amountValue)
        case .update:
            expensesStore.updateExpense(personIndex: personIndex, dayIndex: dayIndex, positionIndex: positionIndex, name: name, amount: amountValue)
        }
        
        action()
    }
    
    public func checkEnteredValue(value: String) -> Double? {
        let doubleValue = Double(value)
        
        return doubleValue
    }
    
    public func checkTranferedExpense(name: String?, amount: Double?) {
        guard let name = name else { return }
        self.name = name
        guard let amount = amount else { return }
        self.amount = String(format: "%.2f", amount)
        
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
