//
//  Expence.swift
//  Expences
//
//  Created by Serhii Prykhodko on 06.10.2020.
//

import Foundation

public struct Expence: Codable {
    
    public let name: String?
    public let amount: Int?
    
    enum CodingKeys : String, CodingKey {
            case name = "WHAT"
            case amount = "AMOUNT"
        }
}
