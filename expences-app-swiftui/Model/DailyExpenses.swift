//
//  WeeklyExpensesByPerson.swift
//  Expenses
//
//  Created by Serhii Prykhodko on 06.10.2020.
//

import Foundation

public struct DailyExpenses: Codable, Identifiable {
    
    public let id = UUID()
    public var dailyExpenses: [Expense]
    
    enum CodingKeys : String, CodingKey {
        case dailyExpenses = "EXPENSE"
    }
    
    public static func emptyDailyExpenses() -> DailyExpenses {
        
            return DailyExpenses(dailyExpenses: [])
        }
}
