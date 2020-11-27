//
//  PersonsListView.swift
//  expences-app-swiftui
//
//  Created by Serhii Prykhodko on 02.11.2020.
//

import SwiftUI

struct PeopleListView: View {
    
    @ObservedObject var expensesStore: ExpensesStore
    
    @State private var isEditMode: EditMode = .inactive
    @State private var showModal: Bool = false
    @State private var operation: OperationType = .create
    @State private var personName: String = ""
    @State private var personIndex: Int = 0
    
    var body: some View {
        List {
            // Check if data is empty - show placeholder text
            if expensesStore.expenses.isEmpty {
                EmptyScreenView(text: "There is no any persons. Try to add one")
            }
            ForEach(expensesStore.expenses.indices, id: \.hashValue) { personIndex in
                let personName = expensesStore.expenses[personIndex].wrappedName
                NavigationLink(destination: PersonExpensesView(expensesStore: expensesStore, personIndex: personIndex, personName: personName)) {
                    Text(expensesStore.expenses[personIndex].wrappedName)
                }
                // Line below makes tapable whole raw, otherwise spacer will be inactive for tapping
                .contentShape(Rectangle())
                // This check allows the NavigationLink to work when edit mode is inactive
                .allowsHitTesting(isEditMode == .inactive ? false : true)
                // Line below makes tap gesture possible for each row in list
                .onTapGesture() {
                    self.personName = personName
                    self.personIndex = personIndex
                    operation = .update
                    showModal.toggle()
                }
            }
            .onDelete(perform: expensesStore.deletePerson)
        }
        .navigationBarTitle("People", displayMode: .inline)
        .navigationBarItems(
            trailing:
                HStack {
                    if isEditMode == .active {
                        Button(action: {
                            personName = ""
                            operation = .create
                            showModal = true
                            
                        }, label: {
                            Image(systemName: "plus")
                        })
                    }
                    EditButton()
                }
        )
        .environment(\.editMode, $isEditMode)
        .sheet(isPresented: $showModal, content: {
            let viewModel = NewPersonViewModel(expensesStore: expensesStore)
            NewPersonView(viewModel: viewModel, isPresented: $showModal, operation: $operation, personName: $personName, personIndex: $personIndex)
        })
    }
}

struct PersonsListView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleListView(expensesStore: ExpensesStore())
    }
}
