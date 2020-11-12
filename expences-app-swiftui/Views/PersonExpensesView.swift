//
//  PersonExpensesView.swift
//  expences-app-swiftui
//
//  Created by Serhii Prykhodko on 02.11.2020.
//

import SwiftUI

struct PersonExpensesView: View {
    
    @EnvironmentObject var expensesStore: ExpensesStore
    
    @State private var isEditMode: EditMode = .inactive
    //@State private var expense: Expense? = nil
    @State var personIndex: Int
    @State private var dayIndex: Int = 0
    @State private var positionIndex: Int = 0
    @State private var expenseName: String?
    @State private var expenseAmount: Double?
    @State private var showModal: Bool = false
    
    var personName: String
    
    var body: some View {
        List {
            if let dayIndicies = expensesStore.expenses[personIndex].weeklyExpenses?.indices {
                ForEach(dayIndicies) { dayIndex in
                    if let dailyExpenses = expensesStore.expenses[personIndex].weeklyExpenses?[dayIndex].dailyExpenses {
                        DayRow(dayIndex: dayIndex, personIndex: personIndex, positionIndex: 0, isEditMode: $isEditMode)
                        showEmptyRow(counter: dailyExpenses.count)
                        ForEach(dailyExpenses.indices, id: \.hashValue) { positionIndex in
                            ExpenseRow(expense: dailyExpenses[positionIndex])
                                // Line below makes tapable whole raw, otherwise spacer will be inactive for tapping
                                .contentShape(Rectangle())
                                // Line below makes tap gesture possible for each row in list
                                .onTapGesture {
                                    self.positionIndex = positionIndex
                                    self.dayIndex = dayIndex
                                    expenseName = dailyExpenses[positionIndex].name
                                    expenseAmount = dailyExpenses[positionIndex].amount
                                    showModal = true
                                }
                        }
                        .onDelete { (indexSet) in
                            expensesStore.deleteExpense(personIndex: personIndex, dayIndex: dayIndex, at: indexSet)
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showModal) {
            let viewModel = ExpenseEditingViewModel(expensesStore: expensesStore)
            ExpenseEditingView(viewModel: viewModel, personIndex: $personIndex, dayIndex: $dayIndex, positionIndex: $positionIndex, expenseName: $expenseName, expenseAmount: $expenseAmount, showModal: $showModal, operation: .update)
        }
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
