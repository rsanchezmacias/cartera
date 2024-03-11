//
//  SchoolViewController.swift
//  Cartera
//
//  Created by Ricardo Sanchez-Macias on 3/6/24.
//

import UIKit
import Combine

class SchoolViewController: UIViewController {
    
    @IBOutlet weak var headerContainerView: SchoolHeaderView!
    @IBOutlet weak var termsContainerView: UIView!
    
    private var school: School?
    
    private var schoolHeaderView: SchoolHeaderView?
    private var termsStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHeaderContainerView()
        setupTerms()
    }
    
    func setupHeaderContainerView() {
        let headerView = SchoolHeaderView()
        self.schoolHeaderView = headerView
        
        headerContainerView.addSubview(headerView)
        headerView.embed(in: headerContainerView)
        
        if let school = school {
            headerView.setup(school: school)
        }
    }
    
    func setupTerms() {
        guard let school = school else { return }
        
        termsStackView = UIStackView()
        termsStackView.axis = .vertical
        termsContainerView.addSubview(termsStackView)
        termsStackView.embed(in: termsContainerView, top: 16, bottom: -16)
        
        for term in school.terms {
            setupTerm(term)
        }
    }
    
    func setupTerm(_ term: Term) {
        let schoolTermViewController = SchoolTermViewController()
        schoolTermViewController.set(term: term)
        
        termsStackView.addArrangedSubview(schoolTermViewController.view)
        self.addChild(schoolTermViewController)
        schoolTermViewController.didMove(toParent: self)
    }
    
    func set(school: School) {
        self.school = school
    }
    
}
