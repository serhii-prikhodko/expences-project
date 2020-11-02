//
//  ContentView.swift
//  expences-app-swiftui
//
//  Created by Serhii Prykhodko on 08.10.2020.
//

import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                NavigationLink(destination: ExpensesListUIView()) {
                    Text("Show Expenses")
                }
                NavigationLink(destination: PeopleListView()) {
                    Text("Show People")
                }
                .navigationBarHidden(true)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}
