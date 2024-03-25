//
//  ObservableJobInfo.swift
//  Cartera
//
//  Created by Ricardo Sanchez-Macias on 3/25/24.
//

import UIKit
import Combine

class ObservableJob {
    
    let title: String
    let company: String
    let imageURL: String
    let startDate: String
    let endDate: String?
    let location: String
    let accomplishments: [String]
    
    @Published var image: UIImage?
    
    init(job: JobInfo) {
        self.title = job.title
        self.company = job.company
        self.imageURL = job.imageURL
        self.startDate = job.startDate
        self.endDate = job.endDate
        self.location = job.location
        self.accomplishments = job.accomplishments
    }
    
    func set(image: UIImage?) {
        self.image = image
    }
    
}
