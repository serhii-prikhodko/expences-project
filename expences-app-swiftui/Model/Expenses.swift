//
//  Expenses.swift
//  Expenses
//
//  Created by Serhii Prykhodko on 06.10.2020.
//

import Foundation

public struct Expenses: Codable {
    
    public let expenses: [ExpensesByPerson]
    
    enum CodingKeys: String, CodingKey {
        case expenses = "expenses"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.expenses = try container.decode([ExpensesByPerson].self, forKey: .expenses)
    }
}
