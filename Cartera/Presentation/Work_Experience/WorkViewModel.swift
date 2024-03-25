//
//  WorkViewModel.swift
//  Cartera
//
//  Created by Ricardo Sanchez-Macias on 3/25/24.
//

import Combine
import Foundation

class WorkViewModel {
    
    private var workManager: WorkManagerProtocol
    
    @Published var jobs: [ObservableJob] = []
    
    private var subscriptions: Set<AnyCancellable> = []
    
    init() {
        workManager = Container.shared.workManager
        
        listenToWorkManager()
    }
    
    private func listenToWorkManager() {
        workManager.workExperience.sink { [weak self] jobs in
            self?.jobs = jobs
        }.store(in: &subscriptions)
    }
    
    func job(for indexPath: IndexPath) -> ObservableJob? {
        guard indexPath.row >= 0 && indexPath.row < jobs.count else {
            return nil
        }
        return jobs[indexPath.row]
    }
    
}
