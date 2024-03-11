//
//  TermInfo.swift
//  Cartera
//
//  Created by Ricardo Sanchez-Macias on 3/6/24.
//

import UIKit

struct Course: Codable {
    
    let code: String
    let title: String
    let grade: String
    
    var colorCode: UIColor?
    
    var category: String {
        let components = code.components(separatedBy: .whitespaces)
        return components.count > 0 ? components[0] : "ERROR"
    }
    
    enum CodingKeys: CodingKey {
        case code
        case title
        case grade
    }
    
}

struct Term: Codable {
    
    let term: String
    var courses: [Course]
    
}
