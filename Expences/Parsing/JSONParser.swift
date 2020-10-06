//
//  JSONParser.swift
//  Expences
//
//  Created by Serhii Prykhodko on 06.10.2020.
//

import Foundation

protocol JSONParserProtocol {
    static func parse(complition: @escaping (Result<Expences?, Error>) -> Void)
}

class JSONParser: JSONParserProtocol {
    
    static func parse(complition: @escaping (Result<Expences?, Error>) -> Void) {
        if let path = Bundle.main.path(forResource: "expences", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                do {
                    let obj = try JSONDecoder().decode(Expences.self, from: data)
                    complition(.success(obj))
                } catch {
                    complition(.failure(error))
                }
            } catch {
                print(error)
            }
        }
    }
}
