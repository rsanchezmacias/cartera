//
//  WorkSummaryViewModel.swift
//  Cartera
//
//  Created by Ricardo Sanchez-Macias on 2/28/24.
//

import Foundation
import Combine

class WorkSummaryViewModel: ObservableObject {
    
    private var workManager: WorkManagerProtocol!
    
    @Published var jobs: [JobInfo] = []
    private var subscriptions: [AnyCancellable] = []
    
    init() {
        workManager = Container.shared.workManager
        
        workManager.workExperience
            .receive(on: RunLoop.main)
            .sink { [weak self] jobs in
                self?.jobs = jobs
            }
            .store(in: &subscriptions)
    }
    
}
