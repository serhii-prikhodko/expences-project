//
//  ExpensesUIView.swift
//  expenses-app-swiftui
//
//  Created by Serhii Prykhodko on 08.10.2020.
//

import SwiftUI

struct ExpensesListUIView: View {
    
    @ObservedObject var expensesStore = ExpensesStore()
    @State var isEditMode: EditMode = .inactive
    
    var body: some View {
        List {
            ForEach(0..<expensesStore.expenses.count) { personIndex in
                let person = expensesStore.expenses[personIndex]
                Section(header: Text(person.name)) {
                    ForEach(0..<person.weeklyExpenses.count) { dayIndex in
                        DayRow(dayIndex: dayIndex, personIndex: personIndex, positionIndex: 0, expensesStore: expensesStore, isEditMode: $isEditMode)
                        ExpensesByDay(expensesByDay: person.weeklyExpenses[dayIndex].dailyExpenses, expensesStore: expensesStore, dayIndex: dayIndex, personIndex: personIndex)
                    }
                }
            }
        }
        .navigationBarTitle("Expenses", displayMode: .inline)
        .listStyle(GroupedListStyle())
        .navigationBarItems(trailing: EditButton())
        .environment(\.editMode, self.$isEditMode)
    }
}

struct ExpensesUIView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesListUIView(isEditMode: .inactive)
    }
}

struct ExpensesByDay: View {
    let expensesByDay: [Expense]
    var expensesStore: ExpensesStore
    var dayIndex: Int
    var personIndex: Int
    @State private var isPresented = false
    
    var body: some View {
        ForEach(expensesByDay) { expense in
            HStack {
                ExpenseRow(expense: expense)
                    // Line below makes tapable whole raw, otherwise spacer will be inactive for tapping
                    .contentShape(Rectangle())
                    // Line below makes tap gesture possible for each row in list
                    .onTapGesture(perform: {
                        isPresented.toggle()
                    })
            }
            .sheet(isPresented: $isPresented) {
                ExpenseEditingView(showModal: $isPresented, personIndex: personIndex, dayIndex: dayIndex, positionIndex: 0, expensesStore: expensesStore, expense: expense)
            }
        }
        .onDelete { (indexSet) in
            expensesStore.deleteExpense(personIndex: personIndex, dayIndex: dayIndex, at: indexSet)
        }
    }
}

struct DayRow: View {
    var dayIndex: Int
    var personIndex: Int
    var positionIndex: Int
    var expensesStore: ExpensesStore
    @State private var isPresented = false
    @Binding var isEditMode: EditMode
    
    var body: some View {
        HStack {
            Text("Day \(dayIndex + 1)")
                .foregroundColor(Color.blue)
            Spacer()
            Button(action: { isPresented.toggle() }) {
                Image(systemName: "plus")
            }
            .sheet(isPresented: $isPresented) {
                ExpenseEditingView(showModal: $isPresented, personIndex: personIndex, dayIndex: dayIndex, positionIndex: positionIndex, expensesStore: expensesStore, expense: nil)
            }
        }
    }
}
