//
//  Container.swift
//  Cartera
//
//  Created by Ricardo Sanchez-Macias on 2/27/24.
//

import Foundation

class Container {
    
    static let shared = Container()
    
    private(set) var profileManager: ProfileManagerProtocol!
    private(set) var workManager: WorkManagerProtocol!
    private(set) var skillsManager: SkillsManagerProtocol!
    private(set) var educationManager: EducationManagerProtocol!
    
    private(set) var imageDownloadService: ImageDownloadServiceProtocol!
    
    func setup() {
        imageDownloadService = ImageDownloadService()
        
        profileManager = ProfileManager()
        workManager = WorkManager(imageDownloadService: imageDownloadService)
        skillsManager = SkillsManager()
        educationManager = EducationManager()
    }
    
}
