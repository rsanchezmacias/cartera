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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHeaderContainerView()
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
    
    func set(school: School) {
        self.school = school
    }
    
}
