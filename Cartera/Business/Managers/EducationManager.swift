//
//  EducationManager.swift
//  Cartera
//
//  Created by Ricardo Sanchez-Macias on 3/6/24.
//

import UIKit
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
    
    private var availableColors: [UIColor] = [
        UIColor(red: 0.22, green: 0.29, blue: 0.36, alpha: 1.0), // Dark Slate
        UIColor(red: 0.31, green: 0.24, blue: 0.13, alpha: 1.0), // Olive
        UIColor(red: 0.36, green: 0.27, blue: 0.20, alpha: 1.0), // Chestnut
        UIColor(red: 0.18, green: 0.24, blue: 0.31, alpha: 1.0), // Midnight Blue
        UIColor(red: 0.22, green: 0.31, blue: 0.13, alpha: 1.0), // Deep Forest Green
        UIColor(red: 0.29, green: 0.18, blue: 0.38, alpha: 1.0), // Aubergine
        UIColor(red: 0.27, green: 0.27, blue: 0.13, alpha: 1.0), // Dark Olive Green
        UIColor(red: 0.38, green: 0.20, blue: 0.24, alpha: 1.0), // Deep Maroon
        UIColor(red: 0.29, green: 0.27, blue: 0.18, alpha: 1.0), // Moss Green
        UIColor(red: 0.33, green: 0.22, blue: 0.27, alpha: 1.0),  // Dark Plum
        UIColor(red: 0.31, green: 0.22, blue: 0.38, alpha: 1.0), // Deep Purple
        UIColor(red: 0.31, green: 0.24, blue: 0.24, alpha: 1.0), // Charcoal Gray
        UIColor(red: 0.13, green: 0.26, blue: 0.36, alpha: 1.0), // Dark Navy
        UIColor(red: 0.36, green: 0.24, blue: 0.11, alpha: 1.0), // Mustard
        UIColor(red: 0.20, green: 0.33, blue: 0.27, alpha: 1.0), // Hunter Green
        UIColor(red: 0.29, green: 0.18, blue: 0.18, alpha: 1.0), // Burgundy
        UIColor(red: 0.33, green: 0.16, blue: 0.16, alpha: 1.0), // Brick Red
        UIColor(red: 0.27, green: 0.18, blue: 0.29, alpha: 1.0), // Plum
        UIColor(red: 0.24, green: 0.22, blue: 0.31, alpha: 1.0)  // Dark Indigo
    ]
    
    private var courseCategoryToColor: [String: UIColor] = [:]
    
    init() {
        schools = CurrentValueSubject<[School], Never>([])
        
        refreshSchoolInfo()
    }
    
    func refreshSchoolInfo() {
        if let schoolInfo = JSONParser.decode(filename: Self.Constants.educationFilename, type: SchoolInfo.self) {
            schools.send(schoolInfo.schools)
            populateColorsMap()
        }
    }
    
    private func populateColorsMap() {
        var schools = schools.value
        var colors = availableColors.map { $0 }
        
        for (i, school) in schools.enumerated() {
            for (j, term) in school.terms.enumerated() {
                for (k, course) in term.courses.enumerated() {
                    if let color = courseCategoryToColor[course.category] {
                        schools[i].terms[j].courses[k].colorCode = color
                    } else {
                        let color: UIColor = colors.popLast() ?? .systemRed
                        courseCategoryToColor[course.category] = color
                        schools[i].terms[j].courses[k].colorCode = color
                    }
                }
            }
        }
        
        self.schools.send(schools)
    }
    
}
