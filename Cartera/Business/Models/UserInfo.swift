//
//  UserInfo.swift
//  Cartera
//
//  Created by Ricardo Sanchez-Macias on 2/27/24.
//

import Foundation

struct UserInfo: Codable {
    
    let fullName: String
    let position: String
    let location: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case position, location
        case fullName = "name"
        case description = "summary"
    }
    
}
