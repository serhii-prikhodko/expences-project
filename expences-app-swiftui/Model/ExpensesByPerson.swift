//
//  WeeklyExpensesByPerson.swift
//  Expenses
//
//  Created by Serhii Prykhodko on 06.10.2020.
//

import Foundation

public struct ExpensesByPerson: Codable,Identifiable {
    
    public let id = UUID()
    public let name: String
    public let weeklyExpenses: [DailyExpenses]
    
    enum CodingKeys: String, CodingKey {
        case name = "WHO"
        case weeklyExpenses = "WEEK"
    }
}
