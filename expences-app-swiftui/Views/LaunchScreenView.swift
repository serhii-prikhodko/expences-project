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
                NavigationLink(destination: ExpensesUIView()) {
                    Text("Show Expenses")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}

//struct GoNextScreenButton: View {
//    var body: some View {
//        Button(action: {
//        }) {
//            Text("Show Expences")
//                .foregroundColor(Color.white)
//                .padding()
//        }
//        .background(Color.blue)
//        .cornerRadius(10)
//    }
//}
