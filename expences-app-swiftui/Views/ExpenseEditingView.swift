//
//  AddExpense.swift
//  expences-app-swiftui
//
//  Created by Serhii Prykhodko on 16.10.2020.
//

import SwiftUI

struct ExpenseEditingView: View {
    
    @Binding var expense: Expense?
    @Binding var personIndex: Int
    @Binding var dayIndex: Int
    @Binding var positionIndex: Int
    
    @State var name = ""
    @State var amount = ""
    @State var showAlert = false
    @State var navigationText = ""
    @State var actionButtonText = ""
    
    @ObservedObject var expensesStore: ExpensesStore
    
    let operation: OperationType
    let alertTitle: String = "Information"
    let alertText: String = "Entered amount is incorrect"
    let alertDismissButtonText: String = "OK"
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Enter name here", text: $name)
                }
                Section(header: Text("Amount")) {
                    TextField("Enter amount here", text: $amount)
                }
            }
            .onAppear(perform: {
                checkTranferedExpense()
                checkOperationType(operation: operation)
            })
            .navigationBarTitle(navigationText, displayMode: .inline)
            .navigationBarItems(
                leading:
                    Button(action: { expense = nil }) {
                        Text("Cancel")
                    },
                trailing:
                    Button(action: { handleExpense(operation: operation) }) {
                        Text(actionButtonText)
                    }
                    .disabled(name.isEmpty || amount.isEmpty)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text(alertTitle), message: Text(alertText), dismissButton: .cancel(Text(alertDismissButtonText)))
                    }
            )
        }
    }
    
    private func handleExpense(operation: OperationType) {
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
    
    private func checkEnteredValue(value: String) -> Double? {
        let doubleValue = Double(value)
        
        return doubleValue
    }
    
    private func checkTranferedExpense() {
        guard let expense = expense else { return }
        name = expense.name
        amount = String(format: "%.2f", expense.amount)
        
    }
    
    private func checkOperationType(operation: OperationType) {
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

struct AddExpense_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseEditingView(expense: .constant(Expense(name: "Item", amount: 1.00)), personIndex: .constant(0), dayIndex: .constant(0), positionIndex: .constant(0), expensesStore: ExpensesStore(), operation: .create )
    }
}
