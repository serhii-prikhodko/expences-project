//
//  NewPersonView.swift
//  expences-app-swiftui
//
//  Created by Serhii Prykhodko on 03.11.2020.
//

import SwiftUI

struct NewPersonView: View {
    
    @State private var personName: String = ""
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Person's name")) {
                    TextField("Enter name here", text: $personName)
                }
            }
            .navigationBarTitle("Create new person record", displayMode: .inline)
            .navigationBarItems(
                leading:
                    Button(action: {isPresented.toggle()}) {
                        Text("Cancel")
                    },
                trailing:
                    Button(action: {isPresented.toggle()}) {
                        Text("Create")
                    }
            )
        }
    }
}

struct NewPersonView_Previews: PreviewProvider {
    static var previews: some View {
        NewPersonView(isPresented: .constant(true))
    }
}
