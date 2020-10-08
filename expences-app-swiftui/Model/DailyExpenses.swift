//
//  WeeklyExpensesByPerson.swift
//  Expenses
//
//  Created by Serhii Prykhodko on 06.10.2020.
//

import Foundation

public struct DailyExpenses: Codable, Identifiable {
    
    public let id: Int
    public let dailyExpenses: [Expense]
    
    enum CodingKeys : String, CodingKey {
        case dailyExpenses = "EXPENSE"
        case id = "ID"
    }
}
