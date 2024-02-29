//
//  SkillsManager.swift
//  Cartera
//
//  Created by Ricardo Sanchez-Macias on 2/29/24.
//

import Foundation
import Combine

protocol SkillsManagerProtocol {
    var languages: CurrentValueSubject<[String], Never>! { get }
    var other: CurrentValueSubject<[String], Never>! { get }
}

class SkillsManager: SkillsManagerProtocol {
    
    struct Constants {
        static let skillsFilename: String = "skills.json"
    }
    
    private(set) var languages: CurrentValueSubject<[String], Never>!
    private(set) var other: CurrentValueSubject<[String], Never>!
    
    init() {
        languages = CurrentValueSubject<[String], Never>([])
        other = CurrentValueSubject<[String], Never>([])
        
        loadSkills()
    }
    
    private func loadSkills() {
        if let skillsResponse = JSONParser.decode(filename: Self.Constants.skillsFilename, type: SkillsResponse.self) {
            languages.send(skillsResponse.skills.languages)
            other.send(skillsResponse.skills.other)
        }
    }
    
}
