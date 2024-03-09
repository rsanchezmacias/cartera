//
//  SchoolTermViewController.swift
//  Cartera
//
//  Created by Ricardo Sanchez-Macias on 3/6/24.
//

import UIKit

class SchoolTermViewController: UIViewController {
    
    private var contentStackView: UIStackView!
    private var titleLabel: UILabel!
    private var titleContainerView: UIView!
    private var collectionViewContainerView: UIView!
    private var collectionView: UICollectionView!
    
    private var term: Term?
    private var courses: [Course] = []
    
    private var collectionViewContainerHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        setupLabelContainer()
        setupCollectionViewContainer()
        setupStackView()
        
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func setup() {
        guard let term = term else {
            return
        }
        
        titleLabel.text = term.term
        courses = term.courses
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
        
        collectionViewContainerHeight.constant = collectionView.collectionViewLayout.collectionViewContentSize.height
    }
    
    func set(term: Term) {
        self.term = term
    }
    
    private func setupStackView() {
        contentStackView = UIStackView(arrangedSubviews: [titleContainerView, collectionViewContainerView])
        self.view.addSubview(contentStackView)
        contentStackView.embed(in: self.view)

        contentStackView.axis = .vertical
    }
    
    private func setupLabelContainer() {
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        titleContainerView = UIView()
        titleContainerView.addSubview(titleLabel)
        titleLabel.embed(in: titleContainerView, left: 24, top: 8, right: 24, bottom: 8)
    }
    
    private func setupCollectionViewContainer() {
        collectionViewContainerView = UIView()
        collectionViewContainerView.addSubview(collectionView)
        collectionView.embed(in: collectionViewContainerView, left: 24, top: 16, right: -24, bottom: 16)
        
        collectionViewContainerHeight = collectionViewContainerView.heightAnchor.constraint(equalToConstant: 400)
        collectionViewContainerHeight.isActive = true
    }
    
    private func configureCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 16
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        
        collectionView.register(UINib(nibName: CourseCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: CourseCollectionViewCell.nibName)
    }
    
}

extension SchoolTermViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return courses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CourseCollectionViewCell.nibName, for: indexPath) as? CourseCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: courses[indexPath.item])
        
        return cell
    }
    
}

