//
//  ExpensesUIView.swift
//  expenses-app-swiftui
//
//  Created by Serhii Prykhodko on 08.10.2020.
//

import SwiftUI

struct ExpensesListUIView: View {
    let data = JSONParser.parse(from: "expenses")
    
    var body: some View {
        List {
            ForEach(data.expenses) { person in
                Section(header: Text(person.name)) {
                    ForEach(0..<person.weeklyExpenses.count) { index in
                        DayRow(index: index)
                        ExpensesByDay(expensesByDay: person.weeklyExpenses[index].dailyExpenses)
                    }
                }
            }
        }
        .navigationBarTitle("Expenses", displayMode: .inline)
        .listStyle(GroupedListStyle())
    }
}

struct ExpensesUIView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesListUIView()
    }
}

struct ExpensesByDay: View {
    let expensesByDay: [Expense]
    var body: some View {
        ForEach(expensesByDay) { expense in
            HStack {
                ExpenseRow(expense: expense)
            }
        }
    }
}

struct DayRow: View {
    var index: Int
    @State private var isPresented = false
    var body: some View {
        HStack {
            Text("Day \(index + 1)")
                .foregroundColor(Color.blue)
            Spacer()
            Button(action: { isPresented.toggle() }) {
                Image(systemName: "plus")
            }
            .sheet(isPresented: $isPresented) {
                expenseEditingView(showModal: $isPresented)
            }
        }
    }
}
