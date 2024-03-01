//
//  NavigationController.swift
//  Cartera
//
//  Created by Ricardo Sanchez-Macias on 3/1/24.
//

import UIKit

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.isTranslucent = false
        navigationBar.tintColor = .white
    }
    
    func configureAsMainNavigationBar(viewController: UIViewController, title: String) {
        removeShadowLine()
        leftAlignTitle(viewController: viewController, title: title)
    }
    
    func removeShadowLine() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
    }
    
    func leftAlignTitle(viewController: UIViewController, title: String) {
        let leftItemLabel = UILabel()
        leftItemLabel.textColor = .black
        leftItemLabel.text = title
        leftItemLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        leftItemLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(leftItemLabel)
        leftItemLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16).isActive = true
        leftItemLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        leftItemLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        leftItemLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: containerView)
        
        self.title = nil
    }
    
}
