//
//  TermInfo.swift
//  Cartera
//
//  Created by Ricardo Sanchez-Macias on 3/6/24.
//

import Foundation

struct Course: Codable {
    
    let code: String
    let title: String
    let grade: String
    
}

struct Term: Codable {
    
    let term: String
    let courses: [Course]
    
}
