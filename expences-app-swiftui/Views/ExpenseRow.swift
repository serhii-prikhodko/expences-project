//
//  ExpenseRow.swift
//  expences-app-swiftui
//
//  Created by Serhii Prykhodko on 09.10.2020.
//

import SwiftUI

struct ExpenseRow: View {
    var expense: Expense
    
    var body: some View {
        HStack {
            Text(expense.name)
                .fontWeight(.bold)
                .padding(.leading)
            Spacer()
            Text("$ \(expense.amount, specifier: "%.2f")")
        }
    }
}

struct ExpenseRow_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseRow(expense: Expense(name: "Apples", amount: 9.00))
    }
}
