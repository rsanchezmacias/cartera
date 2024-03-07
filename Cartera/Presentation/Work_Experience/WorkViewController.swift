//
//  WorkViewController.swift
//  Cartera
//
//  Created by Ricardo Sanchez-Macias on 2/26/24.
//

import UIKit

class WorkViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        (self.navigationController as? NavigationController)?.configureAsMainNavigationBar(viewController: self, title: "Experience")
    }
    
}
