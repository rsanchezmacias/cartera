//
//  WorkViewController.swift
//  Cartera
//
//  Created by Ricardo Sanchez-Macias on 2/26/24.
//

import UIKit
import Combine

class WorkViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var model: WorkViewModel!
    
    private var subscriptions: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        (self.navigationController as? NavigationController)?.configureAsMainNavigationBar(viewController: self, title: "Experience")
        
        model = WorkViewModel()
        
        listenToWorkViewModel()
        setupTableView()
    }
    
    private func listenToWorkViewModel() {
        model.$jobs.receive(on: RunLoop.main).sink { [weak self] _ in
            self?.tableView.reloadData()
        }.store(in: &subscriptions)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: JobCellView.nibName, bundle: nil), forCellReuseIdentifier: JobCellView.nibName)
    }
    
}

extension WorkViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.jobs.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: JobCellView.nibName, for: indexPath) as? JobCellView else {
            return UITableViewCell()
        }
        
        cell.connect(job: model.job(for: indexPath))
        return cell
    }
    
}
