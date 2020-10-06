//
//  WeeklyExpencesByPerson.swift
//  Expences
//
//  Created by Serhii Prykhodko on 06.10.2020.
//

import Foundation

public struct DailyExpences: Codable {
    
    public let dailyExpences: [Expence]?
    
    enum CodingKeys : String, CodingKey {
            case dailyExpences = "EXPENSE"
        }
}
