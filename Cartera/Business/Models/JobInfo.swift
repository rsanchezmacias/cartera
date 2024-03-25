//
//  JobInfo.swift
//  Cartera
//
//  Created by Ricardo Sanchez-Macias on 2/28/24.
//

import Foundation

struct JobInfo: Codable {
    
    let title: String
    let company: String
    let imageURL: String
    let startDate: String
    let endDate: String?
    let location: String
    let accomplishments: [String]
    
    enum CodingKeys: String, CodingKey {
        case title, company, startDate, endDate, location, accomplishments
        case imageURL = "image_url"
    }
    
}

struct JobsResponse: Codable {
    let jobs: [JobInfo]
}
