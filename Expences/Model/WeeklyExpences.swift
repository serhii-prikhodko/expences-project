//
//  WeeklyExpencesByPerson.swift
//  Expences
//
//  Created by Serhii Prykhodko on 06.10.2020.
//

import Foundation

public struct WeeklyExpences: Codable {
    
    public let name: String?
    public let weeklyExpences: [DailyExpences]?
    
    enum CodingKeys: String, CodingKey {
        case name = "WHO"
        case weeklyExpences = "WEEK"
    }
}
