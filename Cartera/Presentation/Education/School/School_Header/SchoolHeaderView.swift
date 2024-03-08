//
//  SchoolHeaderView.swift
//  Cartera
//
//  Created by Ricardo Sanchez-Macias on 3/6/24.
//

import UIKit

class SchoolHeaderView: UIView {
    
    private var school: School!
    private var schoolImageView: UIImageView!
    private var contentStackView: UIStackView!
    
    private var titleLabel: UILabel!
    private var locationLabel: UILabel!
    private var dateLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        common()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        common()
    }
    
    private func common() {
        self.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    func setup(school: School) {
        self.school = school
        setupImageView()
        setupStackView()
        setupInformation()
    }
    
    private func setupImageView() {
        guard let image = UIImage(named: school.imageName) else {
            return
        }
        
        schoolImageView = UIImageView()
        schoolImageView.image = image
        
        self.addSubview(schoolImageView)
        schoolImageView.embed(in: self)
        schoolImageView.contentMode = .scaleAspectFill
        schoolImageView.clipsToBounds = true
        
        schoolImageView.overlay(color: .black, alpha: 0.5)
    }
    
    private func setupInformation() {
        guard school != nil else {
            return
        }
        
        titleLabel.text = school.name
        locationLabel.text = school.location
        dateLabel.text = "\(school.startDate.shortDateFormat() ?? "-") - \(school.graduationDate.shortDateFormat() ?? "-")"
    }
    
}

// MARK: - Configuration

extension SchoolHeaderView {
    
    private func setupStackView() {
        initializeUIComponents()
        
        contentStackView = UIStackView(arrangedSubviews: [titleLabel, locationLabel, dateLabel])
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentStackView.axis = .vertical
        contentStackView.spacing = 8.0
        
        self.addSubview(contentStackView)
        
        contentStackView.centerYAnchor.constraint(equalTo: schoolImageView.centerYAnchor).isActive = true
        contentStackView.leadingAnchor.constraint(equalTo: schoolImageView.leadingAnchor, constant: 24).isActive = true
        contentStackView.trailingAnchor.constraint(equalTo: schoolImageView.trailingAnchor, constant: -24).isActive = true
        contentStackView.topAnchor.constraint(greaterThanOrEqualTo: schoolImageView.topAnchor, constant: 16).isActive = true
        contentStackView.bottomAnchor.constraint(lessThanOrEqualTo: schoolImageView.bottomAnchor, constant: -16).isActive = true
    }
    
    private func initializeUIComponents() {
        titleLabel = backgroundLabel(font: .systemFont(ofSize: 24, weight: .bold))
        locationLabel = backgroundLabel(font: .systemFont(ofSize: 14, weight: .bold))
        dateLabel = backgroundLabel(font: .systemFont(ofSize: 14, weight: .bold))
        
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        
    }
    
    private func backgroundLabel(font: UIFont) -> UILabel {
        let label = UILabel()
        label.textColor = .white
        label.font = font
        label.shadowColor = .black.withAlphaComponent(0.6)
        label.shadowOffset = CGSize(width: 1, height: 1)
        
        return label
    }
    
}
