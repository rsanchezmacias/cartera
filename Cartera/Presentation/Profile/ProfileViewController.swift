//
//  ProfileViewController.swift
//  Cartera
//
//  Created by Ricardo Sanchez-Macias on 2/26/24.
//

import UIKit
import Combine

class ProfileViewController: UIViewController {
    
    struct Constants {
        static let title: String = "Profile"
        static let nameFontSize: CGFloat = 24.0
        static let bodyFontSize: CGFloat = 14.0
        static let sideSpacing: CGFloat = 32.0
    }
    
    @IBOutlet weak var mainContentStackView: UIStackView!
    
    @IBOutlet weak var fullNameLabel: UILabel! {
        didSet {
            fullNameLabel.font = UIFont.systemFont(ofSize: Self.Constants.nameFontSize, weight: .semibold)
            fullNameLabel.adjustsFontSizeToFitWidth = true
        }
    }
    
    @IBOutlet weak var occupationLabel: UILabel! {
        didSet {
            occupationLabel.font = UIFont.systemFont(ofSize: Self.Constants.bodyFontSize, weight: .regular)
        }
    }
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView! {
        didSet {
            profileImageView.layer.cornerRadius = 16.0
        }
    }
    
    @IBOutlet weak var profileDescriptionLabel: UILabel! {
        didSet {
            profileDescriptionLabel.font = UIFont.systemFont(ofSize: Self.Constants.bodyFontSize, weight: .regular)
        }
    }
    
    private var viewModel: ProfileViewModel!
    private var subscriptions: [AnyCancellable] = []
    private var workSummaryViewController: WorkSummaryViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = Self.Constants.title
        
        viewModel = ProfileViewModel()
        subscribe()
        setupWorkSummaryController()
    }
    
    private func subscribe() {
        viewModel.$userImage.sink { [weak self] image in
            self?.profileImageView.image = image
        }.store(in: &subscriptions)
        
        viewModel.$userName.sink { [weak self] name in
            self?.fullNameLabel.text = name
        }.store(in: &subscriptions)
        
        viewModel.$userPosition.sink { [weak self] position in
            self?.occupationLabel.text = position
        }.store(in: &subscriptions)
        
        viewModel.$userDescription.sink { [weak self] description in
            self?.profileDescriptionLabel.text = description
        }.store(in: &subscriptions)
        
        viewModel.$userLocation.sink { [weak self] location in
            self?.configureLocationLabel(location: location)
        }.store(in: &subscriptions)
    }
    
    private func configureLocationLabel(location: String?) {
        if let image = UIImage(systemName: "mappin.circle") {
            let attachment = NSTextAttachment(image: image)
            let attachmentString = NSAttributedString(attachment: attachment)
            
            let labelText = NSAttributedString(string: " \( location ?? "")")
            let mutableStringWithAttachment = NSMutableAttributedString(attributedString: attachmentString)
            mutableStringWithAttachment.append(labelText)
            
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.lightGray,
                .font: UIFont.systemFont(ofSize: Self.Constants.bodyFontSize, weight: .semibold)
            ]
            
            mutableStringWithAttachment.addAttributes(attributes, range: NSRange(location: 0, length: mutableStringWithAttachment.length))
            locationLabel.attributedText = mutableStringWithAttachment
        } else {
            locationLabel.text = viewModel.userLocation
            locationLabel.font = UIFont.systemFont(ofSize: Self.Constants.bodyFontSize, weight: .regular)
            locationLabel.tintColor = .lightGray
        }
    }
    
}

extension ProfileViewController {
    
    func setupWorkSummaryController() {
        workSummaryViewController = WorkSummaryViewController()
        self.addChild(workSummaryViewController)
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.mainContentStackView.addArrangedSubview(containerView)
        
        containerView.addSubview(workSummaryViewController.view)
        workSummaryViewController.view.translatesAutoresizingMaskIntoConstraints = false
        workSummaryViewController.view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        workSummaryViewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Self.Constants.sideSpacing).isActive = true
        workSummaryViewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: Self.Constants.sideSpacing).isActive = true
        workSummaryViewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        
        workSummaryViewController.didMove(toParent: self)
    }
    
}
