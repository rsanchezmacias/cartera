//
//  Skills.swift
//  Cartera
//
//  Created by Ricardo Sanchez-Macias on 2/29/24.
//

import Foundation

struct SkillsInfo: Codable {
    let languages: [String]
    let other: [String]
    
    enum CodingKeys: String, CodingKey {
        case languages, other
    }
}

struct SkillsResponse: Codable {
    let skills: SkillsInfo
}
