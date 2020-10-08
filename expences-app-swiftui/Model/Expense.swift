//
//  Expense.swift
//  Expenses
//
//  Created by Serhii Prykhodko on 06.10.2020.
//

import Foundation

public struct Expense: Codable, Identifiable {
    
    public let id: Int
    public let name: String
    public let amount: Int
    
    enum CodingKeys : String, CodingKey {
            case id = "ID"
            case name = "WHAT"
            case amount = "AMOUNT"
        }
}
