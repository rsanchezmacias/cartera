//
//  WorkManager.swift
//  Cartera
//
//  Created by Ricardo Sanchez-Macias on 2/28/24.
//

import Combine

protocol WorkManagerProtocol {
    
    var workExperience: CurrentValueSubject<[JobInfo], Never>! { get }

    func getWorkExperience() -> Future<[JobInfo], Error>
    
}

class WorkManager: WorkManagerProtocol {
    
    struct Constants {
        static let jobsFilename: String = "jobs.json"
    }
    
    private var jobs: [JobInfo] = []
    private(set) var workExperience: CurrentValueSubject<[JobInfo], Never>!
    
    init() {
        workExperience = CurrentValueSubject<[JobInfo], Never>([])
        
        if let response = JSONParser.decode(filename: Self.Constants.jobsFilename, type: JobsResponse.self) {
            self.jobs = response.jobs
            workExperience.send(self.jobs)
        }
    }
    
    func getWorkExperience() -> Future<[JobInfo], Error> {
        return Future { [weak self] promise in
            guard let self = self else { return }
            promise(.success(self.jobs))
        }
    }
    
}
