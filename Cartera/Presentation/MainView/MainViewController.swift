//
//  ViewController.swift
//  Cartera
//
//  Created by Ricardo Sanchez-Macias on 2/22/24.
//

import UIKit

class MainViewController: UITabBarController {
    
    struct Constants {
        static let separatorHeight: CGFloat = 1
    }
    
    private var profileNavigationController: UINavigationController!
    private var educationNavigationController: UINavigationController!
    private var workNavigationController: UINavigationController!
    
    private var separatorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupContent()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.addSeparatorLine()
    }
    
    private func setupContent() {
        let profileVC = ProfileViewController.instantiateFrom(storyboardName: "ProfileViewController")
        let educationVC = EducationViewController.instantiateFrom(storyboardName: "EducationViewController")
        let workVC = WorkViewController.instantiateFrom(storyboardName: "WorkViewController")
        
        profileNavigationController = UINavigationController(rootViewController: profileVC!)
        educationNavigationController = UINavigationController(rootViewController: educationVC!)
        workNavigationController = UINavigationController(rootViewController: workVC!)
        
        // Configure tab bar
        self.viewControllers = [profileNavigationController, educationNavigationController, workNavigationController]
        
        profileNavigationController.tabBarItem = TabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), tag: 0)
        educationNavigationController.tabBarItem = TabBarItem(title: "Education", image: UIImage(systemName: "graduationcap"), tag: 1)
        workNavigationController.tabBarItem = TabBarItem(title: "Jobs", image: UIImage(systemName: "suitcase"), tag: 2)
    }
    
    private func addSeparatorLine() {
        separatorView = UIView()
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = .lightGray
        
        self.tabBar.addSubview(separatorView)
        
        let constraints: [NSLayoutConstraint] = [
            separatorView.topAnchor.constraint(equalTo: self.tabBar.topAnchor),
            separatorView.leadingAnchor.constraint(equalTo: self.tabBar.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: self.tabBar.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: Self.Constants.separatorHeight)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
