//
//  AddExpense.swift
//  expences-app-swiftui
//
//  Created by Serhii Prykhodko on 16.10.2020.
//

import SwiftUI

struct ExpenseEditingView: View {
    
    @ObservedObject var viewModel: ExpenseEditingViewModel
    
    @Binding var expense: ExpenseItem?
    
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
                viewModel.checkTranferedExpense(expense: expense)
                viewModel.checkOperationType(operation: operation)
            })
            .navigationBarTitle(viewModel.navigationText, displayMode: .inline)
            .navigationBarItems(
                leading:
                    Button(action: { dismissView() }) {
                        Text("Cancel")
                    },
                trailing:
                    Button(action: {
                        viewModel.handleExpense(operation: operation, expense: expense, action: dismissView)
                    }) {
                        Text(viewModel.actionButtonText)
                    }
                    .disabled(viewModel.name.isEmpty || viewModel.amount.isEmpty)
                    .alert(isPresented: $viewModel.showAlert) {
                        Alert(title: Text(alertTitle), message: Text(alertText), dismissButton: .cancel(Text(alertDismissButtonText)))
                    }
            )
        }
    }
    
    private func dismissView() {
        expense = nil
    }
}

struct AddExpense_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ExpenseEditingViewModel(expensesStore: ExpensesStore())
        ExpenseEditingView(viewModel: viewModel, expense: .constant(ExpenseItem(name: "Apple", amount: 1.25)), operation: .create)
    }
}
