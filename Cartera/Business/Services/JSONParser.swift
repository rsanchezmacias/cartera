//
//  JSONParser.swift
//  Cartera
//
//  Created by Ricardo Sanchez-Macias on 2/26/24.
//

import Foundation

class JSONParser {
    
    static let jsonDecoder = JSONDecoder()
    
    static func decode<T: Decodable>(filename: String, type: T.Type) -> T? {
        guard let resourceURL = Bundle.main.url(forResource: filename, withExtension: nil) else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: resourceURL)
            let object: T = try jsonDecoder.decode(type, from: data)
            return object
        } catch {
            return nil
        }
    }
    
}
