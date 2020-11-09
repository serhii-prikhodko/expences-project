//
//  expenses_app_swiftuiApp.swift
//  expenses-app-swiftui
//
//  Created by Serhii Prykhodko on 08.10.2020.
//

import SwiftUI

@main
struct expences_app_swiftuiApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var expensesStore = ExpensesStore()
    var body: some Scene {
        WindowGroup {
            LaunchScreenView().environmentObject(expensesStore)
        }
    }
}
