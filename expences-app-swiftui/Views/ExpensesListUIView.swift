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
    
    var body: some View {
        List {
            ForEach(expensesStore.expenses) { personExpenses in
                Section(header: Text(personExpenses.wrappedName)) {
                    ForEach(personExpenses.weeklyExpensesArray) {dailyExpenses in
                        DayRow(isEditMode: $isEditMode, expensesStore: expensesStore)
                        let counter = dailyExpenses.expensesArray.count
                        showEmptyRow(counter: counter)
                        ForEach(dailyExpenses.expensesArray){ expense in
                            ExpenseRow(expense: expense)
                                //Line below makes tapable whole raw, otherwise spacer will be inactive for tapping
                                .contentShape(Rectangle())
                                // Line below makes tap gesture possible for each row in list
                                .onTapGesture {
                                    self.expense = expense
                                }
                        }
                        .onDelete(perform: self.expensesStore.deleteExpense)
                    }
                }
            }
        }
        .sheet(item: $expense, content: { expense in
            let viewModel = ExpenseEditingViewModel(expensesStore: expensesStore)
            ExpenseEditingView(viewModel: viewModel, expense: $expense, operation: .update)
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
                ExpenseEditingView(viewModel: viewModel, expense: $expense, operation: .create)
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
