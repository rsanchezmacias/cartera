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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with course: Course) {
        courseTitleLabel.text = course.title
        courseCodeLabel.text = course.code
        courseGradeLabel.text = course.grade
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let attributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        
        attributes.size = CGSize(width: 150, height: 100)
        return attributes
    }
    
}
