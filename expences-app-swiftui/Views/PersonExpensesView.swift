//
//  PersonExpensesView.swift
//  expences-app-swiftui
//
//  Created by Serhii Prykhodko on 02.11.2020.
//

import SwiftUI

struct PersonExpensesView: View {
    
    @ObservedObject var expensesStore = ExpensesStore()
    
    @State private var isEditMode: EditMode = .inactive
    @State private var expense: Expense? = nil
    @State var personIndex: Int
    @State private var dayIndex: Int = 0
    @State private var positionIndex: Int = 0
    
    var personName: String
    
    var body: some View {
        List {
            ForEach(expensesStore.expenses[personIndex].weeklyExpenses.indices, id: \.hashValue) { dayIndex in
                let dailyExpenses = expensesStore.expenses[personIndex].weeklyExpenses[dayIndex]
                DayRow(dayIndex: dayIndex, personIndex: personIndex, positionIndex: 0, isEditMode: $isEditMode, expensesStore: expensesStore)
                ForEach(dailyExpenses.dailyExpenses.indices) { positionIndex in
                    ExpenseRow(expense: dailyExpenses.dailyExpenses[positionIndex])
                        // Line below makes tapable whole raw, otherwise spacer will be inactive for tapping
                        .contentShape(Rectangle())
                        // Line below makes tap gesture possible for each row in list
                        .onTapGesture {
                            self.positionIndex = positionIndex
                            self.dayIndex = dayIndex
                            expense = dailyExpenses.dailyExpenses[positionIndex]
                        }
                }
                .onDelete { (indexSet) in
                    expensesStore.deleteExpense(personIndex: personIndex, dayIndex: dayIndex, at: indexSet)
                }
            }
        }
        .sheet(item: $expense, content: { expense in
            let viewModel = ExpenseEditingViewModel(expensesStore: expensesStore)
            ExpenseEditingView(viewModel: viewModel, personIndex: $personIndex, dayIndex: $dayIndex, positionIndex: $positionIndex, expense: $expense, operation: .update)
        })
        .navigationBarTitle(personName, displayMode: .inline)
        .listStyle(GroupedListStyle())
        .navigationBarItems(trailing: EditButton())
        .environment(\.editMode, $isEditMode)
    }
}
