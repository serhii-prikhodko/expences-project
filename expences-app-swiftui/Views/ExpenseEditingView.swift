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
    
    var operation: OperationType
    var alertTitle: String = "Information"
    var alertText: String = "Entered amount is incorrect"
    var alertDismissButtonText: String = "OK"
    
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
                    .disabled(self.name.isEmpty || self.amount.isEmpty)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text(self.alertTitle), message: Text(self.alertText), dismissButton: .cancel(Text(self.alertDismissButtonText)))
                    }
            )
        }
    }
    
    private func handleExpense(operation: OperationType) {
        let enteredAmount = checkEnteredValue(value: self.amount)
        guard let amountValue = enteredAmount else {
            self.amount = ""
            self.showAlert = true
            
            return
        }
        let expense = Expense(name: self.name, amount: amountValue)
        
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
        self.name = expense.name
        self.amount = String(format: "%.2f", expense.amount)
        
    }
    
    private func checkOperationType(operation: OperationType) {
        switch operation {
        case .create:
            self.navigationText = "Add New Expense"
            self.actionButtonText = "Create"
        case .update:
            self.navigationText = "Update Expense"
            self.actionButtonText = "Save"
        }
    }
}

struct AddExpense_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseEditingView(expense: .constant(Expense(name: "Item", amount: 1.00)), personIndex: .constant(0), dayIndex: .constant(0), positionIndex: .constant(0), expensesStore: ExpensesStore(), operation: .create )
    }
}
