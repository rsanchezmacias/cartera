//
//  PillLabelView.swift
//  Cartera
//
//  Created by Ricardo Sanchez-Macias on 2/29/24.
//

import UIKit

class PillLabelCollectionViewCell: UICollectionViewCell {
    
    static let reusableIdentifier: String = "PillLabelCollectionViewCell"
    
    private var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        common()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        common()
    }
    
    func common() {
        // Setup label
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: ProfileViewController.Constants.bodyFontSize, weight: .semibold)
        label.clipsToBounds = true
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        // Add layer to pill
        self.layer.cornerRadius = PillsHorizontalViewController.collectionViewHeight / 2
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1.0
        
        self.addSubview(label)
        
        let constraints: [NSLayoutConstraint] = [
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            label.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -16),
            label.topAnchor.constraint(equalTo: self.topAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setup(pillText: String) {
        label.text = pillText
    }
    
    static func calculateTextWidth(text: String) -> CGFloat {
        return text.width(
            withFont: UIFont.systemFont(ofSize: ProfileViewController.Constants.bodyFontSize, weight: .semibold),
            height: PillsHorizontalViewController.collectionViewHeight
        ) + 32
    }
    
}
