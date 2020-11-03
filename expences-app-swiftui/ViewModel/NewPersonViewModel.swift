//
//  NewPersonViewModel.swift
//  expences-app-swiftui
//
//  Created by Serhii Prykhodko on 03.11.2020.
//

import Foundation

class NewPersonViewModel: ObservableObject {
    
    @Published var expensesStore: ExpensesStore
    @Published var personName: String = ""
    
    init(expensesStore: ExpensesStore) {
        self.expensesStore = expensesStore
    }
}
