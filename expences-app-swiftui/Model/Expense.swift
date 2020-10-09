//
//  Expense.swift
//  Expenses
//
//  Created by Serhii Prykhodko on 06.10.2020.
//

import Foundation

public struct Expense: Codable, Identifiable {
    
    public let id = UUID()
    public let name: String
    public let amount: Double
    
    enum CodingKeys : String, CodingKey {
            case name = "WHAT"
            case amount = "AMOUNT"
        }
}
