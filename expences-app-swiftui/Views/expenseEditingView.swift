//
//  AddExpense.swift
//  expences-app-swiftui
//
//  Created by Serhii Prykhodko on 16.10.2020.
//

import SwiftUI

struct expenseEditingView: View {
    
    @Binding var showModal: Bool
    @State var name = ""
    @State var amount = ""
    
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
            )
        }
    }
    
    private func addExpense() {
        
    }
}

struct AddExpense_Previews: PreviewProvider {
    static var previews: some View {
        expenseEditingView(showModal: .constant(true))
    }
}
