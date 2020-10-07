//
//  Expences.swift
//  Expences
//
//  Created by Serhii Prykhodko on 06.10.2020.
//

import Foundation

public struct Expences: Codable {
    
    public let expences: [WeeklyExpences]?
    
    enum CodingKeys: String, CodingKey {
        case expences = "expences"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.expences = try container.decode([WeeklyExpences].self, forKey: .expences)
    }
}
