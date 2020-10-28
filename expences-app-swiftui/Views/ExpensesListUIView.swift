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
            ForEach(expensesStore.expenses.indices) { personIndex in
                let person = expensesStore.expenses[personIndex]
                Section(header: Text(person.name)) {
                    ForEach(person.weeklyExpenses.indices) { dayIndex in
                        DayRow(dayIndex: dayIndex, personIndex: personIndex, positionIndex: 0, isEditMode: $isEditMode, expensesStore: expensesStore)
                        ForEach(person.weeklyExpenses[dayIndex].dailyExpenses.indices, id: \.hashValue) { positionIndex in
                            ExpenseRow(expense: person.weeklyExpenses[dayIndex].dailyExpenses[positionIndex])
                                // Line below makes tapable whole raw, otherwise spacer will be inactive for tapping
                                .contentShape(Rectangle())
                                // Line below makes tap gesture possible for each row in list
                                .onTapGesture {
                                    self.positionIndex = positionIndex
                                    self.dayIndex = dayIndex
                                    self.personIndex = personIndex
                                    expense = person.weeklyExpenses[dayIndex].dailyExpenses[positionIndex]
                                }
                        }
                        .onDelete { (indexSet) in
                            expensesStore.deleteExpense(personIndex: personIndex, dayIndex: dayIndex, at: indexSet)
                        }
                    }
                }
            }
        }
        .sheet(item: $expense, content: { expense in
            ExpenseEditingView(viewModel: ExpenseEditingViewModel(expensesStore: expensesStore, showAlert: false), personIndex: $personIndex, dayIndex: $dayIndex, positionIndex: $positionIndex, expense: $expense, operation: .update)
        })
        .navigationBarTitle("Expenses", displayMode: .inline)
        .listStyle(GroupedListStyle())
        .navigationBarItems(trailing: EditButton())
        .environment(\.editMode, $isEditMode)
    }
}

struct ExpensesUIView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesListUIView()
    }
}

struct DayRow: View {
    @State var dayIndex: Int
    @State var personIndex: Int
    @State var positionIndex: Int
    @State private var expense: Expense? = nil
    
    @Binding var isEditMode: EditMode
    
    var expensesStore: ExpensesStore
    
    var body: some View {
        HStack {
            Text("Day \(dayIndex + 1)")
                .foregroundColor(Color.blue)
            Spacer()
            Button(action: { expense = Expense(name: "", amount: 0) }) {
                Image(systemName: "plus")
            }
            .sheet(item: $expense, content: { expense in
                ExpenseEditingView(viewModel: ExpenseEditingViewModel(expensesStore: expensesStore, showAlert: false), personIndex: $personIndex, dayIndex: $dayIndex, positionIndex: $positionIndex, expense: $expense, operation: .create)
            })
        }
    }
}
