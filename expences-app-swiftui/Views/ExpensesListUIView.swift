//
//  ExpensesUIView.swift
//  expenses-app-swiftui
//
//  Created by Serhii Prykhodko on 08.10.2020.
//

import SwiftUI

struct ExpensesListUIView: View {
    
    @ObservedObject private var expensesStore = ExpensesStore()
    @State private var isEditMode: EditMode = .inactive
    @State private var expense: Expense? = nil
    @State private var positionIndex: Int = 0
    @State private var dayIndex: Int = 0
    @State private var personIndex: Int = 0
    
    var body: some View {
        List {
            ForEach(0..<expensesStore.expenses.count) { personIndex in
                let person = expensesStore.expenses[personIndex]
                Section(header: Text(person.name)) {
                    ForEach(0..<person.weeklyExpenses.count) { dayIndex in
                        DayRow(dayIndex: dayIndex, personIndex: personIndex, positionIndex: 0, expensesStore: expensesStore, isEditMode: $isEditMode)
                        ForEach(0..<person.weeklyExpenses[dayIndex].dailyExpenses.count) { positionIndex in
                            ExpenseRow(expense: person.weeklyExpenses[dayIndex].dailyExpenses[positionIndex])
                                // Line below makes tapable whole raw, otherwise spacer will be inactive for tapping
                                .contentShape(Rectangle())
                                // Line below makes tap gesture possible for each row in list
                                .onTapGesture(perform: {
                                    expense = person.weeklyExpenses[dayIndex].dailyExpenses[positionIndex]
                                    self.positionIndex = positionIndex
                                    self.dayIndex = dayIndex
                                    self.personIndex = personIndex
                                })
                        }
                        .onDelete { (indexSet) in
                            expensesStore.deleteExpense(personIndex: personIndex, dayIndex: dayIndex, at: indexSet)
                        }
                    }
                }
            }
        }
        .sheet(item: $expense, content: { expense in
            ExpenseEditingView(expense: $expense, personIndex: personIndex, dayIndex: dayIndex, positionIndex: positionIndex, expensesStore: expensesStore, operation: .update)
        })
        .navigationBarTitle("Expenses", displayMode: .inline)
        .listStyle(GroupedListStyle())
        .navigationBarItems(trailing: EditButton())
        .environment(\.editMode, self.$isEditMode)
    }
}

struct ExpensesUIView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesListUIView()
    }
}

struct DayRow: View {
    var dayIndex: Int
    var personIndex: Int
    var positionIndex: Int
    var expensesStore: ExpensesStore
    @State private var expense: Expense? = nil
    @Binding var isEditMode: EditMode
    
    var body: some View {
        HStack {
            Text("Day \(dayIndex + 1)")
                .foregroundColor(Color.blue)
            Spacer()
            Button(action: { expense = Expense(name: "", amount: 0) }) {
                Image(systemName: "plus")
            }
            .sheet(item: $expense, content: { expense in
                ExpenseEditingView(expense: $expense, personIndex: personIndex, dayIndex: dayIndex, positionIndex: positionIndex, expensesStore: expensesStore, operation: .create)
            })
        }
    }
}
