//
//  EmptyViewText.swift
//  expences-app-swiftui
//
//  Created by Serhii Prykhodko on 25.11.2020.
//

import SwiftUI

struct EmptyScreenView: View {
    var text: String
    var body: some View {
        HStack {
            Text(text)
                .foregroundColor(.gray)
                .italic()
        }
    }
}
