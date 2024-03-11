//
//  CourseCollectionViewCell.swift
//  Cartera
//
//  Created by Ricardo Sanchez-Macias on 3/8/24.
//

import UIKit

class CourseCollectionViewCell: UICollectionViewCell {
    
    static let nibName: String = "CourseCollectionViewCell"
    
    @IBOutlet weak var courseTitleLabel: UILabel!
    @IBOutlet weak var courseCodeLabel: UILabel!
    @IBOutlet weak var courseGradeLabel: UILabel!
    
    @IBOutlet weak var contentContainer: UIView!
    @IBOutlet weak var codeContainerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        beautifyUI()
    }
    
    func beautifyUI() {
        courseCodeLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        courseGradeLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        courseTitleLabel.font = .systemFont(ofSize: 14, weight: .regular)
        
        contentContainer.layer.borderColor = UIColor.lightGray.cgColor
        contentContainer.layer.borderWidth = 1
        contentContainer.layer.cornerRadius = 8
        contentContainer.layer.masksToBounds = true
        codeContainerView.layer.backgroundColor = UIColor.systemTeal.cgColor
    }
    
    func configure(with course: Course) {
        courseTitleLabel.text = course.title
        courseCodeLabel.text = course.code
        courseGradeLabel.text = course.grade
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let attributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        
        attributes.size = CGSize(width: 160, height: 100)
        return attributes
    }
    
}
