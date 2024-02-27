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
    
    private var navigationControllers: [UINavigationController]!
    
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
        let viewControllers = AppTab.allCases.compactMap { appTab in
            let viewController = UIViewController.instantiateFrom(storyboardName: appTab.viewControllerName)
            viewController?.tabBarItem = TabBarItem(title: appTab.tabBarTitle, image: UIImage(systemName: appTab.tabBarImageName), tag: appTab.tabBarID)
            return viewController
        }
        
        self.navigationControllers = viewControllers.map { viewController in
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.tabBarItem = viewController.tabBarItem
            return navigationController
        }
        
        // Configure tab bar
        self.viewControllers = self.navigationControllers
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
