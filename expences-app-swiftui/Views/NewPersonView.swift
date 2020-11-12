//
//  NewPersonView.swift
//  expences-app-swiftui
//
//  Created by Serhii Prykhodko on 03.11.2020.
//

import SwiftUI

struct NewPersonView: View {
    
    @ObservedObject var viewModel: NewPersonViewModel
    
    @Binding var isPresented: Bool
    @Binding var operation: OperationType
    @Binding var personName: String
    @Binding var personIndex: Int
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Person's name")) {
                    TextField("Enter name here", text: $viewModel.personName)
                }
            }
            .navigationBarTitle(viewModel.navigationText, displayMode: .inline)
            .navigationBarItems(
                leading:
                    Button(action: {isPresented.toggle()}) {
                        Text("Cancel")
                    },
                trailing:
                    Button(action: {
                            viewModel.handlePerson(operation: operation, personIndex: personIndex)
                            isPresented.toggle()}) {
                        Text(viewModel.actionButtonText)
                    }
                    .disabled(viewModel.personName.isEmpty)
            )
            .onAppear(perform: {
                viewModel.checkOperationType(operation: operation)
                viewModel.setPersonNameInTextField(personName: personName)
            })
        }
    }
}

//struct NewPersonView_Previews: PreviewProvider {
//    static var previews: some View {
//        let viewModel = NewPersonViewModel(expensesStore: ExpensesStore())
//        NewPersonView(viewModel: viewModel, isPresented: .constant(true), operation: .constant(.create), personName: .constant(""), personIndex: .constant(0))
//    }
//}
