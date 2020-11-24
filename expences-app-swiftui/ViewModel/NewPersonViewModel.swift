//
//  NewPersonViewModel.swift
//  expences-app-swiftui
//
//  Created by Serhii Prykhodko on 03.11.2020.
//

import Foundation

//class NewPersonViewModel: ObservableObject {
//    
//    @Published var expensesStore: ExpensesStore
//    @Published var personName: String = ""
//    @Published var navigationText = ""
//    @Published var actionButtonText = ""
//    
//    init(expensesStore: ExpensesStore) {
//        self.expensesStore = expensesStore
//    }
//    
//    public func handlePerson(operation: OperationType, personIndex: Int) {
//        switch operation {
//        case .create:
//            expensesStore.addPerson(name: personName)
//        case .update:
//            expensesStore.updatePersonName(name: personName, personIndex: personIndex)
//        }
//    }
//    
//    public func checkOperationType(operation: OperationType) {
//        switch operation {
//        case .create:
//            navigationText = "Add New Person"
//            actionButtonText = "Create"
//        case .update:
//            navigationText = "Update Person"
//            actionButtonText = "Save"
//        }
//    }
//    
//    public func setPersonNameInTextField(personName: String) {
//        self.personName = personName
//    }
//}
