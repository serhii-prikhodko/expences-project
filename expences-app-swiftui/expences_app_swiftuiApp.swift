//
//  expenses_app_swiftuiApp.swift
//  expenses-app-swiftui
//
//  Created by Serhii Prykhodko on 08.10.2020.
//

import SwiftUI
import CoreData

@main
struct expences_app_swiftuiApp: App {
    
    let persistenceManager: PersistenceController
    @StateObject var expensesStore: ExpensesStore
    
    init() {
        let manager = PersistenceController()
        self.persistenceManager = manager
        
        let managedObjectContext = manager.container.viewContext
        let storage = ExpensesStore(managedObjectContext: managedObjectContext)
        self._expensesStore = StateObject(wrappedValue: storage)
    }
    
    var body: some Scene {
        WindowGroup {
            LaunchScreenView(expensesStore: expensesStore)
                .environmentObject(expensesStore)
        }
    }
}
