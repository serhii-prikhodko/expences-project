//
//  PersonExpensesView.swift
//  expences-app-swiftui
//
//  Created by Serhii Prykhodko on 02.11.2020.
//

import SwiftUI

struct PersonExpensesView: View {
    
    @ObservedObject private var expensesStore = ExpensesStore()
    @State private var isEditMode: EditMode = .inactive
    var personExpenses: ExpensesByPerson
    var personIndex: Int
    var personName: String
    
    var body: some View {
        List {
            ForEach(personExpenses.weeklyExpenses.indices) { dayIndex in
                DayRow(dayIndex: dayIndex, personIndex: personIndex, positionIndex: 0, isEditMode: $isEditMode, expensesStore: expensesStore)
                ForEach(personExpenses.weeklyExpenses[dayIndex].dailyExpenses.indices, id: \.hashValue) { positionIndex in
                    ExpenseRow(expense: personExpenses.weeklyExpenses[dayIndex].dailyExpenses[positionIndex])
                        // Line below makes tapable whole raw, otherwise spacer will be inactive for tapping
                        .contentShape(Rectangle())
                }
            }
        }
        .navigationBarTitle(personName, displayMode: .inline)
        .listStyle(GroupedListStyle())
        .navigationBarItems(trailing: EditButton())
        .environment(\.editMode, $isEditMode)
    }
}

//struct PersonExpensesView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        PersonExpensesView(personExpenses: createPreviewExample())
//    }
//
//    private func createPreviewExample() -> ExpensesByPerson {
//        let expense = Expense(name: "Cold beer", amount: 2.20)
//        let dailyExpenses = DailyExpenses(dailyExpenses: [expense])
//        let expensesByPerson = ExpensesByPerson(name: "Stan", weeklyExpenses: [dailyExpenses])
//
//        return expensesByPerson
//    }
//}
