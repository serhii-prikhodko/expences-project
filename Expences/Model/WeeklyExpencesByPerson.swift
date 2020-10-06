//
//  WeeklyExpencesByPerson.swift
//  Expences
//
//  Created by Serhii Prykhodko on 06.10.2020.
//

import Foundation

public struct WeeklyExpencesByPerson: Codable {
    
    public let name: String?
    public let weeklyExpences: [WeeklyExpences]?
    
    enum CodingKeys: String, CodingKey {
        case name = "WHO"
        case weeklyExpences = "WEEK"
    }
}
