//
//  JSONParser.swift
//  Expenses
//
//  Created by Serhii Prykhodko on 06.10.2020.
//

import Foundation

class JSONParser {
    
    static func parse(from file: String) -> Expenses {
        guard let path = Bundle.main.path(forResource: file, ofType: "json") else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        guard let expenses = try? decoder.decode(Expenses.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        return expenses
    }
}
