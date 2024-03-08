//
//  EducationViewModel.swift
//  Cartera
//
//  Created by Ricardo Sanchez-Macias on 3/8/24.
//

import Combine

class EducationViewModel: ObservableObject {
    
    private var educationManager: EducationManagerProtocol
    
    @Published var schools: [School] = []
    private var subscriptions: [AnyCancellable] = []
    
    init() {
        educationManager = Container.shared.educationManager
        
        subscribeToEducationManager()
    }
    
    private func subscribeToEducationManager() {
        educationManager.schools.sink { [weak self] schools in
            self?.schools = schools
        }.store(in: &subscriptions)
    }
    
}

