//
//  WorkManager.swift
//  Cartera
//
//  Created by Ricardo Sanchez-Macias on 2/28/24.
//

import Combine
import Foundation

protocol WorkManagerProtocol {
    
    var workExperience: CurrentValueSubject<[ObservableJob], Never>! { get }

    func getWorkExperience() -> Future<[ObservableJob], Error>
    
}

class WorkManager: WorkManagerProtocol {
    
    struct Constants {
        static let jobsFilename: String = "jobs.json"
    }
    
    private var imageDownloadService: ImageDownloadServiceProtocol!
    
    private var jobs: [ObservableJob] = []
    private(set) var workExperience: CurrentValueSubject<[ObservableJob], Never>!
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    
    init(imageDownloadService: ImageDownloadServiceProtocol) {
        self.imageDownloadService = imageDownloadService
        
        workExperience = CurrentValueSubject<[ObservableJob], Never>([])
        
        if let response = JSONParser.decode(filename: Self.Constants.jobsFilename, type: JobsResponse.self) {
            self.jobs = response.jobs.map { ObservableJob(job: $0) }.sorted(by: { jobA, jobB in
                let jobADate = dateFormatter.date(from: jobA.startDate) ?? Date()
                let jobBDate = dateFormatter.date(from: jobB.startDate) ?? Date()
                return jobADate > jobBDate
            })
            workExperience.send(self.jobs)
            
            downloadImages()
        }
    }
    
    func getWorkExperience() -> Future<[ObservableJob], Error> {
        return Future { [weak self] promise in
            guard let self = self else { return }
            promise(.success(self.jobs))
        }
    }
    
    private func downloadImages() {
        self.jobs.forEach { job in
            Task.init {
                do {
                    let image = try await imageDownloadService.downloadImage(url: job.imageURL)
                    job.set(image: image)
                } catch {
                    print("Error downloading image")
                }
            }
        }
    }
    
}
