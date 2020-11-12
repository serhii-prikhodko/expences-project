//
//  ExpensesUIView.swift
//  expenses-app-swiftui
//
//  Created by Serhii Prykhodko on 08.10.2020.
//

import SwiftUI

struct ExpensesListUIView: View {
    
    @EnvironmentObject var expensesStore: ExpensesStore
    
    @State private var isEditMode: EditMode = .inactive
    @State private var positionIndex: Int = 0
    @State private var dayIndex: Int = 0
    @State private var personIndex: Int = 0
    @State private var expenseName: String?
    @State private var expenseAmount: Double?
    @State private var showModal: Bool = false
    
    var body: some View {
        List {
            ForEach(expensesStore.expenses.indices) { personIndex in
                if let name = expensesStore.expenses[personIndex].name, let weeklyExpenses = expensesStore.expenses[personIndex].weeklyExpenses {
                    Section(header: Text(name)) {
                        ForEach(weeklyExpenses.indices) { dayIndex in
                            if let dailyExpenses = weeklyExpenses[dayIndex].dailyExpenses {
                                DayRow(dayIndex: dayIndex, personIndex: personIndex, positionIndex: 0, isEditMode: $isEditMode)
                                let counter = dailyExpenses.count
                                showEmptyRow(counter: counter)
                                ForEach(dailyExpenses.indices, id: \.hashValue) { positionIndex in
                                    ExpenseRow(expense: dailyExpenses[positionIndex])
                                        // Line below makes tapable whole raw, otherwise spacer will be inactive for tapping
                                        .contentShape(Rectangle())
                                        // Line below makes tap gesture possible for each row in list
                                        .onTapGesture {
                                            self.positionIndex = positionIndex
                                            self.dayIndex = dayIndex
                                            self.personIndex = personIndex
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
            }
        }
        .sheet(isPresented: $showModal) {
            let viewModel = ExpenseEditingViewModel(expensesStore: expensesStore)
            ExpenseEditingView(viewModel: viewModel, personIndex: $personIndex, dayIndex: $dayIndex, positionIndex: $positionIndex, expenseName: $expenseName, expenseAmount: $expenseAmount, showModal: $showModal, operation: .update)
        }
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

//struct ExpensesUIView_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        ExpensesListUIView()
//    }
//}

struct DayRow: View {
    @State var dayIndex: Int
    @State var personIndex: Int
    @State var positionIndex: Int
    @State private var showModal: Bool = false
    @State private var expenseName: String?
    @State private var expenseAmount: Double?
    
    @Binding var isEditMode: EditMode
    
    @EnvironmentObject var expensesStore: ExpensesStore
    
    var body: some View {
        HStack {
            Text("Day \(dayIndex + 1)")
                .foregroundColor(Color.dayCellTextColor)
            Spacer()
            Button(action: { showModal = true }) {
                Image(systemName: "plus")
            }
            .foregroundColor(Color.dayCellTextColor)
            .sheet(isPresented: $showModal){
                let viewModel = ExpenseEditingViewModel(expensesStore: expensesStore)
                ExpenseEditingView(viewModel: viewModel, personIndex: $personIndex, dayIndex: $dayIndex, positionIndex: $positionIndex, expenseName: $expenseName, expenseAmount: $expenseAmount, showModal: $showModal, operation: .create)
            }
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
