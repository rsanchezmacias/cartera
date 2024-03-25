//
//  JobCellView.swift
//  Cartera
//
//  Created by Ricardo Sanchez-Macias on 3/25/24.
//

import UIKit
import Combine

class JobCellView: UITableViewCell {
    
    static let nibName: String = "JobCellView"
    
    @IBOutlet weak var positionLabel: UILabel! {
        didSet {
            positionLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        }
    }
    
    
    @IBOutlet weak var companyLabel: UILabel! {
        didSet {
            companyLabel.font = .systemFont(ofSize: 14, weight: .regular)
        }
    }
    
    
    @IBOutlet weak var dateLabel: UILabel! {
        didSet {
            dateLabel.font = .systemFont(ofSize: 14, weight: .regular)
            dateLabel.textColor = .gray
        }
    }
    
    
    @IBOutlet weak var locationLabel: UILabel! {
        didSet {
            locationLabel.font = .systemFont(ofSize: 14, weight: .regular)
            locationLabel.textColor = .lightGray
        }
    }
    
    @IBOutlet weak var jobDescriptionLabel: UILabel! {
        didSet {
            jobDescriptionLabel.font = .systemFont(ofSize: 14)
        }
    }
    
    @IBOutlet weak var companyImageView: UIImageView! {
        didSet {
            companyImageView.contentMode = .scaleAspectFit
            companyImageView.clipsToBounds = true
        }
    }
    
    private var spinnerView: UIActivityIndicatorView!
    
    private var subscription: AnyCancellable?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        self.selectionStyle = .none
        
        spinnerView = UIActivityIndicatorView()
        spinnerView.startAnimating()
        
        companyImageView.addSubview(spinnerView)
        spinnerView.translatesAutoresizingMaskIntoConstraints = false
        spinnerView.centerXAnchor.constraint(equalTo: companyImageView.centerXAnchor).isActive = true
        spinnerView.centerYAnchor.constraint(equalTo: companyImageView.centerYAnchor).isActive = true
    }
    
    func connect(job: ObservableJob?) {
        guard let job = job else {
            return
        }
        
        subscription?.cancel()
        
        subscription = job.$image.receive(on: RunLoop.main).sink(receiveValue: { [weak self] image in
            self?.companyImageView.image = image
            self?.spinnerView.stopAnimating()
        })
        
        // MARK: - Set text for labels
        
        positionLabel.text = job.title
        companyLabel.text = job.company
        
        if let endDate = job.endDate {
            dateLabel.text = "\(job.startDate.shortDateFormat() ?? "-") - \(endDate.shortDateFormat() ?? "-")"
        } else {
            dateLabel.text = "\(job.startDate.shortDateFormat() ?? "-") - Present"
        }
        
        locationLabel.text = job.location
        
        var description: String = ""
        for accomplishment in job.accomplishments {
            description += String(format: "• %@ \n \n", accomplishment)
        }
        jobDescriptionLabel.text = description
    }
    
}
