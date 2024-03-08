//
//  EducationViewController.swift
//  Cartera
//
//  Created by Ricardo Sanchez-Macias on 2/26/24.
//

import UIKit
import Combine

class EducationViewController: UIViewController {
    
    /// EducationViewController.storyboard - mainContentStackView uses a temporary constraint to satisfy autolayout
    @IBOutlet weak var mainContentStackView: UIStackView!
    
    private var model: EducationViewModel?
    
    private var subscriptions: [AnyCancellable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        (self.navigationController as? NavigationController)?.configureAsMainNavigationBar(viewController: self, title: "Education")
        
        model = EducationViewModel()
        setupSchools()
    }
    
    private func setupSchools() {
        model?.$schools.sink(receiveValue: { [weak self] schools in
            self?.build(schools: schools)
        }).store(in: &subscriptions)
    }
    
    private func build(schools: [School]) {
        for school in schools {
            let schoolViewController = SchoolViewController.instantiateFrom(storyboardName: "SchoolViewController")
            addToView(viewController: schoolViewController, school: school)
        }
    }
    
    private func addToView(viewController: SchoolViewController?, school: School) {
        guard let viewController = viewController else {
            return
        }
        
        viewController.set(school: school)
        
        self.addChild(viewController)
        self.mainContentStackView.addArrangedSubview(viewController.view)
        
        viewController.didMove(toParent: self)        
    }
    
}
