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
            Spacer()
            Text("Amount: \(expense.amount)")
        }
    }
}

struct ExpenseRow_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseRow(expense: Expense(id: 1, name: "Apples", amount: 9))
    }
}
