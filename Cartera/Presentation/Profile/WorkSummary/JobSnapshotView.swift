//
//  JobSnapshotView.swift
//  Cartera
//
//  Created by Ricardo Sanchez-Macias on 2/28/24.
//

import UIKit

class JobSnapshotView: UIView {
    
    static let nibName: String = "JobSnapshotView"
    
    @IBOutlet weak var timelineTopLine: UIView!
    @IBOutlet weak var timelineBottomLine: UIView!
    
    @IBOutlet weak var timelineDot: UIView! {
        didSet {
            timelineDot.layer.cornerRadius = 5
            timelineDot.backgroundColor = .black
        }
    }
    
    @IBOutlet weak var positionLabel: UILabel! {
        didSet {
            positionLabel.font = UIFont.systemFont(ofSize: ProfileViewController.Constants.bodyFontSize, weight: .semibold)
        }
    }
    
    @IBOutlet weak var companyLabel: UILabel! {
        didSet {
            companyLabel.font = UIFont.systemFont(ofSize: ProfileViewController.Constants.bodyFontSize, weight: .regular)
        }
    }
    
    @IBOutlet weak var dateLabel: UILabel! {
        didSet {
            dateLabel.font = UIFont.systemFont(ofSize: ProfileViewController.Constants.bodyFontSize, weight: .semibold)
            dateLabel.textColor = .lightGray
        }
    }
    
    func setupWith(job: ObservableJob, isTopRow: Bool = false) {
        companyLabel.text = job.company
        positionLabel.text = job.title
        timelineTopLine.isHidden = isTopRow
        
        if let endDate = job.endDate {
            dateLabel.text = "\(job.startDate.shortDateFormat() ?? "-") - \(endDate.shortDateFormat() ?? "-")"
        } else {
            dateLabel.text = "\(job.startDate.shortDateFormat() ?? "-") - Present"
        }
    }
    
}
