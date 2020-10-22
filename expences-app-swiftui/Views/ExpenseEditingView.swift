//
//  AddExpense.swift
//  expences-app-swiftui
//
//  Created by Serhii Prykhodko on 16.10.2020.
//

import SwiftUI

struct ExpenseEditingView: View {
    
    @Binding var expense: Expense?
    @State var name = ""
    @State var amount = ""
    @State var showAlert = false
    var personIndex: Int
    var dayIndex: Int
    var positionIndex: Int
    let expensesStore: ExpensesStore
    var operation: OperationType
    @State var navigationText = ""
    @State var actionButtonText = ""
    
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
                        Alert(title: Text("Information"), message: Text("Entered amount is incorrect"), dismissButton: .cancel(Text("OK")))
                    }
            )
        }
    }
    
    private func handleExpense(operation: OperationType) {
        let enteredAmount = checkEnteredValue(value: self.amount)
        guard enteredAmount != nil else {
            self.amount = ""
            self.showAlert = true
            
            return
        }
        let expense = Expense(name: self.name, amount: enteredAmount!)
        
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
        guard self.expense != nil else { return }
        self.name = self.expense!.name
        self.amount = String(format: "%.2f", self.expense!.amount)
        
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
        ExpenseEditingView(expense: .constant(Expense(name: "Item", amount: 1.00)), personIndex: 0, dayIndex: 0, positionIndex: 0, expensesStore: ExpensesStore(), operation: .create )
    }
}
