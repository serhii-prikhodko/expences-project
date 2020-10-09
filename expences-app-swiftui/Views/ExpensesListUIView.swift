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
                    let allPersonExpensesArray = returnDailyArray(expensesByPerson: person)
                    ForEach(allPersonExpensesArray) { expense in
                        HStack {
                            ExpenseRow(expense: expense)
                        }
                    }
                }
            }
        }
        .navigationBarTitle("Expenses", displayMode: .inline)
        .listStyle(GroupedListStyle())
    }
    func returnDailyArray(expensesByPerson: ExpensesByPerson) -> [Expense] {
        var array = [Expense]()
        for dailyExpenses in expensesByPerson.weeklyExpenses {
            for expense in dailyExpenses.dailyExpenses {
                array.append(expense)
            }
        }
        
        return array
    }
}

struct ExpensesUIView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesListUIView()
    }
}
