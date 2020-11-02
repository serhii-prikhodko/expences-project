//
//  PersonsListView.swift
//  expences-app-swiftui
//
//  Created by Serhii Prykhodko on 02.11.2020.
//

import SwiftUI

struct PersonsListView: View {
    
    @ObservedObject private var expensesStore = ExpensesStore()
    
    var body: some View {
        List {
            ForEach(expensesStore.expenses.indices) { personIndex in
                let personName = expensesStore.expenses[personIndex].name
                NavigationLink(destination: PersonExpensesView(personIndex: personIndex, personName: personName)) {
                    Text(expensesStore.expenses[personIndex].name)
                }
            }
            
        }
        .navigationBarTitle("People", displayMode: .inline)
    }
}

struct PersonsListView_Previews: PreviewProvider {
    static var previews: some View {
        PersonsListView()
    }
}
