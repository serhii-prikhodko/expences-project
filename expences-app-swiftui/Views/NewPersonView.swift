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
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Person's name")) {
                    TextField("Enter name here", text: $viewModel.personName)
                }
            }
            .navigationBarTitle("Create new person record", displayMode: .inline)
            .navigationBarItems(
                leading:
                    Button(action: {isPresented.toggle()}) {
                        Text("Cancel")
                    },
                trailing:
                    Button(action: {
                            viewModel.createPerson()
                            isPresented.toggle()}) {
                        Text("Create")
                    }
                    .disabled(viewModel.personName.isEmpty)
            )
        }
    }
}

struct NewPersonView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = NewPersonViewModel(expensesStore: ExpensesStore())
        NewPersonView(viewModel: viewModel, isPresented: .constant(true))
    }
}
