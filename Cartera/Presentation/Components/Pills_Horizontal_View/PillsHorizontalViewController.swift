//
//  PillsHorizontalViewController.swift
//  Cartera
//
//  Created by Ricardo Sanchez-Macias on 2/29/24.
//

import UIKit
import Combine

class PillsHorizontalViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    static let collectionViewHeight: CGFloat = 30.0
    
    private var pills: [String] = []
    private var cancellable: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 8
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Register UICollectionViewCell 
        collectionView.register(PillLabelCollectionViewCell.self, forCellWithReuseIdentifier: PillLabelCollectionViewCell.reusableIdentifier)
        
        // Add collection view to current view
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: Self.collectionViewHeight)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32)
    }
    
    func connectPills(pillsPublisher: AnyPublisher<[String], Never>) {
        cancellable = pillsPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] pills in
                self?.pills = pills
                self?.collectionView.reloadData()
            }
    }
    
}

extension PillsHorizontalViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pills.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PillLabelCollectionViewCell.reusableIdentifier, for: indexPath) as? PillLabelCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setup(pillText: pills[indexPath.item])
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let pillText = pills[indexPath.item]
        let width = PillLabelCollectionViewCell.calculateTextWidth(text: pillText)
        return CGSize(width: width, height: Self.collectionViewHeight)
    }
    
}
