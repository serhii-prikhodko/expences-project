//
//  EspensesStore.swift
//  expences-app-swiftui
//
//  Created by Serhii Prykhodko on 19.10.2020.
//

import Foundation

class ExpensesStore: ObservableObject {
    
    @Published var expenses = loadExpenses()
    
    static func loadExpenses() -> [ExpensesByPerson] {
        let data = JSONParser.parse(from: "expenses")
        let expensesData = data.expenses
        
        return expensesData
    }
    
    func addExpense(person: Int, day: Int, position: Int, expense: Expense) {
        self.expenses[person].weeklyExpenses[day].dailyExpenses.insert(expense, at: position)
    }
    
    func updateExpense(person: Int, day: Int, position: Int, expense: Expense) {
        self.expenses[person].weeklyExpenses[day].dailyExpenses[position] = expense
    }
    
    func deleteExpense(person: Int, day: Int, position: Int) {
        self.expenses[person].weeklyExpenses[day].dailyExpenses.remove(at: position)
    }
}
