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
    }
    
    @IBOutlet weak var fullNameLabel: UILabel! {
        didSet {
            fullNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        }
    }
    
    
    @IBOutlet weak var profileImageView: UIImageView! {
        didSet {
            profileImageView.layer.cornerRadius = 16.0
        }
    }
    
    private var viewModel: ProfileViewModel!
    private var subscriptions: [AnyCancellable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = Self.Constants.title
        
        viewModel = ProfileViewModel()
        subscribe()
    }
    
    private func subscribe() {
        viewModel.$userImage.sink { [weak self] image in
            self?.profileImageView.image = image
        }.store(in: &subscriptions)
        
        viewModel.$userName.sink { [weak self] name in
            self?.fullNameLabel.text = name
        }.store(in: &subscriptions)
    }
    
}
