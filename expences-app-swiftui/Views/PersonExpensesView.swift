//
//  PersonExpensesView.swift
//  expences-app-swiftui
//
//  Created by Serhii Prykhodko on 02.11.2020.
//

import SwiftUI

struct PersonExpensesView: View {
    
    @ObservedObject var expensesStore: ExpensesStore
    
    @State private var isEditMode: EditMode = .inactive
    @State private var expense: ExpenseItem? = nil
    @State var personIndex: Int
    @State private var dayIndex: Int = 0
    @State private var positionIndex: Int = 0
    
    var personName: String
    
    var body: some View {
        List {
            ForEach(expensesStore.expenses[personIndex].weeklyExpensesArray.indices) {dayIndex in
                let dailyExpenses = expensesStore.expenses[personIndex].weeklyExpensesArray[dayIndex]
                DayRow(personIndex: personIndex, dayIndex: dayIndex, isEditMode: $isEditMode, expensesStore: expensesStore)
                let counter = dailyExpenses.expensesArray.count
                showEmptyRow(counter: counter)
                ForEach(dailyExpenses.expensesArray){ expense in
                    ExpenseRow(expense: expense)
                        //Line below makes tapable whole raw, otherwise spacer will be inactive for tapping
                        .contentShape(Rectangle())
                        // Line below makes tap gesture possible for each row in list
                        .onTapGesture {
                            self.dayIndex = dayIndex
                            self.expense = expense
                        }
                }
                .onDelete { (indexSet) in
                    expensesStore.deleteExpense(personIndex: personIndex, dayIndex: dayIndex, at: indexSet)
                }
            }
        }
        .sheet(item: $expense, content: { expense in
            let viewModel = ExpenseEditingViewModel(expensesStore: expensesStore)
            ExpenseEditingView(viewModel: viewModel, expense: $expense, personIndex: $personIndex, dayIndex: $dayIndex, operation: .update)
        })
        .navigationBarTitle(personName, displayMode: .inline)
        .listStyle(GroupedListStyle())
        .navigationBarItems(trailing: EditButton())
        .environment(\.editMode, $isEditMode)
    }
    private func showEmptyRow(counter: Int) -> EmptyRow? {
        guard counter == 0 else {return nil}
        
        return EmptyRow()
    }
}
