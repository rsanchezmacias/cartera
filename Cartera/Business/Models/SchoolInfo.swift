//
//  SchoolInfo.swift
//  Cartera
//
//  Created by Ricardo Sanchez-Macias on 3/6/24.
//

import Foundation

struct School: Codable {
    
    let name: String
    let imageName: String
    let location: String
    let startDate: String
    let graduationDate: String
    let details: [String]
    let terms: [Term]

    enum CodingKeys: String, CodingKey {
        case name
        case imageName = "image_name"
        case location
        case startDate = "start_date"
        case graduationDate = "graduation_date"
        case details
        case terms
    }
}

struct SchoolInfo: Codable {
    let schools: [School]
}
