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
        static let sectionFontSize: CGFloat = 18.0
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
    private var skillsPillViewController: PillsHorizontalViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        (self.navigationController as? NavigationController)?.configureAsMainNavigationBar(viewController: self, title: "Profile")
        
        viewModel = ProfileViewModel()
        setupSkillsPillViewController()
        setupWorkSummaryController()
        
        subscribe()
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
        
        // Convert skills information to any publisher for the pills view controller to consume
        skillsPillViewController.connectPills(pillsPublisher: viewModel.$skills.eraseToAnyPublisher())
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
    
    func setupSkillsPillViewController() {
        skillsPillViewController = PillsHorizontalViewController()
        self.addChild(skillsPillViewController)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        let titleContainer = UIView()
        let titleLabel = UILabel()
        titleLabel.text = "Skills"
        titleLabel.font = UIFont.systemFont(ofSize: Self.Constants.sectionFontSize, weight: .bold)
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        titleContainer.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleContainer.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: titleContainer.leadingAnchor, constant: 32).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: titleContainer.bottomAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: titleContainer.trailingAnchor, constant: -32).isActive = true
        titleLabel.topAnchor.constraint(equalTo: titleContainer.topAnchor).isActive = true
        
        
        let pillsContainer = UIView()
        pillsContainer.translatesAutoresizingMaskIntoConstraints = false
        skillsPillViewController.view.translatesAutoresizingMaskIntoConstraints = false
        pillsContainer.addSubview(skillsPillViewController.view)
        
        skillsPillViewController.view.leadingAnchor.constraint(equalTo: pillsContainer.leadingAnchor).isActive = true
        skillsPillViewController.view.bottomAnchor.constraint(equalTo: pillsContainer.bottomAnchor, constant: -32).isActive = true
        skillsPillViewController.view.trailingAnchor.constraint(equalTo: pillsContainer.trailingAnchor).isActive = true
        skillsPillViewController.view.topAnchor.constraint(equalTo: pillsContainer.topAnchor, constant: 12).isActive = true
        
        
        stackView.addArrangedSubview(titleContainer)
        stackView.addArrangedSubview(pillsContainer)
        
        self.mainContentStackView.addArrangedSubview(stackView)
        
        skillsPillViewController.didMove(toParent: self)
    }
    
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
        workSummaryViewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Self.Constants.sideSpacing).isActive = true
        workSummaryViewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        
        workSummaryViewController.didMove(toParent: self)
    }
    
}
