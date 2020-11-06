//
//  ContentView.swift
//  expences-app-swiftui
//
//  Created by Serhii Prykhodko on 08.10.2020.
//

import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack(spacing: 20) {
                    NavigationLink(destination: ExpensesListUIView()) {
                        Text("Show Expenses")
                            .frame(width: geometry.size.width/2)
                            .titleStyle()
                    }
                    NavigationLink(destination: PeopleListView()) {
                        Text("Show People")
                            .frame(width: geometry.size.width/2)
                            .titleStyle()
                    }
                    .navigationBarHidden(true)
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(10)
            .background(Color.buttonBackgroundColor)
            .clipShape(Capsule())
            .foregroundColor(Color.textColor)
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}
