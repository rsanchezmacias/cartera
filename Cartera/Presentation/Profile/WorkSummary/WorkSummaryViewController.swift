//
//  WorkSummaryViewController.swift
//  Cartera
//
//  Created by Ricardo Sanchez-Macias on 2/28/24.
//

import UIKit
import Combine

class WorkSummaryViewController: UIViewController {
    
    struct Constants {
        static let titleText: String = "Experience"
    }
    
    private var model: WorkSummaryViewModel!
    
    private var titleLabel: UILabel!
    private var mainStackView: UIStackView!
    
    private var subscriptions: [AnyCancellable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitleLabel()
        setupStackView()
        
        model = WorkSummaryViewModel()
        subscribeToViewModel()
    }
    
    private func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        titleLabel.font = UIFont.systemFont(ofSize: ProfileViewController.Constants.sectionFontSize, weight: .bold)
        titleLabel.text = Self.Constants.titleText
        
        self.view.addSubview(titleLabel)
        
        let constraints: [NSLayoutConstraint] = [
            titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupStackView() {
        mainStackView = UIStackView()
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        
        self.view.addSubview(mainStackView)
        
        let constraints: [NSLayoutConstraint] = [
            mainStackView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8),
            mainStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func subscribeToViewModel() {
        model.$jobs.sink { [weak self] jobs in
            self?.addJobViews(jobs: jobs)
        }.store(in: &subscriptions)
    }
    
    private func addJobViews(jobs: [JobInfo]) {
        mainStackView.arrangedSubviews.forEach { view in
            mainStackView.removeArrangedSubview(view)
            NSLayoutConstraint.deactivate(view.constraints)
            view.removeFromSuperview()
        }
        
        for index in 0..<jobs.count {
            let nib = UINib(nibName: JobSnapshotView.nibName, bundle: nil)
            let objects = nib.instantiate(withOwner: nil)
            
            if let snapshotView = objects.first as? JobSnapshotView {
                snapshotView.setupWith(job: jobs[index], isTopRow: index == 0)
                
                mainStackView.addArrangedSubview(snapshotView)
            }
        }
    }
    
}
