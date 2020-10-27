//
//  AddExpense.swift
//  expences-app-swiftui
//
//  Created by Serhii Prykhodko on 16.10.2020.
//

import SwiftUI

struct ExpenseEditingView: View {
    
    
    @State var navigationText = ""
    @State var actionButtonText = ""
    
    @ObservedObject var viewModel: ExpenseEditingViewModel
    
    let operation: OperationType
    let alertTitle: String = "Information"
    let alertText: String = "Entered amount is incorrect"
    let alertDismissButtonText: String = "OK"
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Enter name here", text: $viewModel.name)
                }
                Section(header: Text("Amount")) {
                    TextField("Enter amount here", text: $viewModel.amount)
                }
            }
            .onAppear(perform: {
                viewModel.checkTranferedExpense()
                checkOperationType(operation: operation)
            })
            .navigationBarTitle(navigationText, displayMode: .inline)
            .navigationBarItems(
                leading:
                    Button(action: { viewModel.expense = nil }) {
                        Text("Cancel")
                    },
                trailing:
                    Button(action: { viewModel.handleExpense(operation: operation) }) {
                        Text(actionButtonText)
                    }
                    .disabled(viewModel.name.isEmpty || viewModel.amount.isEmpty)
                    .alert(isPresented: $viewModel.showAlert) {
                        Alert(title: Text(alertTitle), message: Text(alertText), dismissButton: .cancel(Text(alertDismissButtonText)))
                    }
            )
        }
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
        ExpenseEditingView(viewModel: ExpenseEditingViewModel(expensesStore: ExpensesStore(), expense: Expense(name: "Item", amount: 1.00), personIndex: 0, dayIndex: 0, positionIndex: 0, showAlert: true), operation: .create)
    }
}
