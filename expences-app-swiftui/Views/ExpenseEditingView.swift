//
//  AddExpense.swift
//  expences-app-swiftui
//
//  Created by Serhii Prykhodko on 16.10.2020.
//

import SwiftUI

struct ExpenseEditingView: View {
    
    @Binding var showModal: Bool
    @State var name = ""
    @State var amount = ""
    @State var showAlert = false
    
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
            .navigationBarTitle("Add New Expense", displayMode: .inline)
            .navigationBarItems(
                leading:
                    Button(action: { showModal.toggle() }) {
                        Text("Cancel")
                    },
                trailing:
                    Button(action: addExpense) {
                        Text("Add")
                    }
                    .disabled(self.name.isEmpty || self.amount.isEmpty)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Information"), message: Text("Entered amount is incorrect"), dismissButton: .cancel(Text("OK")))
                    }
            )
        }
    }
    
    private func addExpense() {
        let enteredAmount = checkEnteredValue(value: self.amount)
        guard enteredAmount != nil else {
            self.amount = ""
            self.showAlert = true
            
            return
        }
        
        let expense = Expense(name: self.name, amount: enteredAmount!)
        print(expense)
    }
    
    private func checkEnteredValue(value: String) -> Double? {
        let doubleValue = Double(value)
        
        return doubleValue
    }
}

struct AddExpense_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseEditingView(showModal: .constant(true))
    }
}
