//
//  ExpensesUIView.swift
//  expenses-app-swiftui
//
//  Created by Serhii Prykhodko on 08.10.2020.
//

import SwiftUI

struct ExpensesListUIView: View {
    
    @ObservedObject var expensesStore: ExpensesStore
    
    @State private var isEditMode: EditMode = .inactive
    @State private var expense: ExpenseItem? = nil
    @State private var personIndex: Int = 0
    @State private var dayIndex: Int = 0
    
    var body: some View {
        List {
            ForEach(expensesStore.expenses.indices, id: \.hashValue) { personIndex in
                let personExpenses = expensesStore.expenses[personIndex]
                Section(header: Text(personExpenses.wrappedName)) {
                    ForEach(personExpenses.weeklyExpensesArray.indices) {dayIndex in
                        let dailyExpenses = personExpenses.weeklyExpensesArray[dayIndex]
                        DayRow(personIndex: personIndex, dayIndex: dayIndex, isEditMode: $isEditMode, expensesStore: expensesStore)
                        let counter = dailyExpenses.expensesArray.count
                        showEmptyRow(counter: counter)
                        ForEach(dailyExpenses.expensesArray){ expense in
                            ExpenseRow(expense: expense)
                                //Line below makes tapable whole raw, otherwise spacer will be inactive for tapping
                                .contentShape(Rectangle())
                                // Line below makes tap gesture possible for each row in list
                                .onTapGesture {
                                    self.personIndex = personIndex
                                    self.dayIndex = dayIndex
                                    self.expense = expense
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
            let viewModel = ExpenseEditingViewModel(expensesStore: expensesStore)
            ExpenseEditingView(viewModel: viewModel, expense: $expense, personIndex: $personIndex, dayIndex: $dayIndex, operation: .update)
        })
        .navigationBarTitle("Expenses", displayMode: .inline)
        .listStyle(GroupedListStyle())
        .navigationBarItems(trailing: EditButton())
        .environment(\.editMode, $isEditMode)
    }
    
    private func showEmptyRow(counter: Int) -> EmptyRow? {
        guard counter == 0 else {return nil}
        
        return EmptyRow()
    }
}

struct ExpensesUIView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesListUIView(expensesStore: ExpensesStore())
    }
}

struct DayRow: View {
    
    @State private var expense: ExpenseItem? = nil
    @State var personIndex: Int
    @State var dayIndex: Int
    
    @Binding var isEditMode: EditMode
    
    @ObservedObject var expensesStore: ExpensesStore
    
    var body: some View {
        HStack {
            Text("Day")
                .foregroundColor(Color.dayCellTextColor)
            Spacer()
            Button(action: { expense = ExpenseItem(name: "", amount: 0) }) {
                Image(systemName: "plus")
            }
            .foregroundColor(Color.dayCellTextColor)
            .sheet(item: $expense, content: { expense in
                let viewModel = ExpenseEditingViewModel(expensesStore: expensesStore)
                ExpenseEditingView(viewModel: viewModel, expense: $expense, personIndex: $personIndex, dayIndex: $dayIndex, operation: .create)
            })
        }
    }
}

struct EmptyRow: View {
    var body: some View {
        Text("Add some items here")
            .foregroundColor(.gray)
            .italic()
            .padding(.leading)
    }
}
