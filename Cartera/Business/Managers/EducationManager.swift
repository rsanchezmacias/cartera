//
//  EducationManager.swift
//  Cartera
//
//  Created by Ricardo Sanchez-Macias on 3/6/24.
//

import Foundation
import Combine

protocol EducationManagerProtocol {
    var schools: CurrentValueSubject<[School], Never> { get }
    
    func refreshSchoolInfo()
}

class EducationManager: EducationManagerProtocol {
    
    struct Constants {
        static let educationFilename: String = "education.json"
    }
    
    private(set) var schools: CurrentValueSubject<[School], Never>
    
    init() {
        schools = CurrentValueSubject<[School], Never>([])
        
        refreshSchoolInfo()
    }
    
    func refreshSchoolInfo() {
        if let schoolInfo = JSONParser.decode(filename: Self.Constants.educationFilename, type: SchoolInfo.self) {
            schools.send(schoolInfo.schools)
        }
    }
    
}
