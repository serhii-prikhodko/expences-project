//
//  PersonsListView.swift
//  expences-app-swiftui
//
//  Created by Serhii Prykhodko on 02.11.2020.
//

import SwiftUI

struct PeopleListView: View {
    
    @ObservedObject private var expensesStore = ExpensesStore()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct PersonsListView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleListView()
    }
}
