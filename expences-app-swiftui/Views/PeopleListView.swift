//
//  PersonsListView.swift
//  expences-app-swiftui
//
//  Created by Serhii Prykhodko on 02.11.2020.
//

import SwiftUI

struct PeopleListView: View {
    
    @ObservedObject private var expensesStore = ExpensesStore()
    
    @State private var isEditMode: EditMode = .inactive
    @State private var showModal: Bool = false
    
    var body: some View {
        List {
            ForEach(expensesStore.expenses.indices, id: \.hashValue) { personIndex in
                let personName = expensesStore.expenses[personIndex].name
                NavigationLink(destination: PersonExpensesView(personIndex: personIndex, personName: personName)) {
                    Text(expensesStore.expenses[personIndex].name)
                }
            }
            .onDelete(perform: expensesStore.deletePerson)
        }
        .navigationBarTitle("People", displayMode: .inline)
        .navigationBarItems(
            trailing:
                HStack {
                    if isEditMode == .active {
                        Button(action: { showModal = true }, label: {
                            Image(systemName: "plus")
                        })
                    }
                    EditButton()
                }
        )
        .environment(\.editMode, $isEditMode)
        .sheet(isPresented: $showModal, content: {
            let viewModel = NewPersonViewModel(expensesStore: expensesStore)
            NewPersonView(viewModel: viewModel, isPresented: $showModal)
        })
    }
}

struct PersonsListView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleListView()
    }
}
