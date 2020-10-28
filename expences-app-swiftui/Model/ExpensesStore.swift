//
//  EspensesStore.swift
//  expences-app-swiftui
//
//  Created by Serhii Prykhodko on 19.10.2020.
//

import Foundation

protocol ExpensesStoreProtocol {
    
    static func loadExpenses() -> [ExpensesByPerson]
}

class ExpensesStore: ObservableObject, ExpensesStoreProtocol {
    
    @Published var expenses = loadExpenses()
    
    static func loadExpenses() -> [ExpensesByPerson] {
        let data = JSONParser.parse(from: "expenses")
        let expensesData = data.expenses
        
        return expensesData
    }
    
    func addExpense(personIndex: Int, dayIndex: Int, expense: Expense) {
        expenses[personIndex].weeklyExpenses[dayIndex].dailyExpenses.append(expense)
    }
    
    func updateExpense(personIndex: Int, dayIndex: Int, positionIndex: Int, expense: Expense) {
        expenses[personIndex].weeklyExpenses[dayIndex].dailyExpenses[positionIndex] = expense
    }
    
    func deleteExpense(personIndex: Int, dayIndex: Int, at offsets: IndexSet) {
        expenses[personIndex].weeklyExpenses[dayIndex].dailyExpenses.remove(atOffsets: offsets)
    }
}
