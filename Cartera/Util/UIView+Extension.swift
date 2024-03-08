//
//  UIView+Extension.swift
//  Cartera
//
//  Created by Ricardo Sanchez-Macias on 3/7/24.
//

import UIKit

extension UIView {
    
    func embed(in view: UIView, left: CGFloat = 0, top: CGFloat = 0, right: CGFloat = 0, bottom: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false 
        
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: left).isActive = true
        self.topAnchor.constraint(equalTo: view.topAnchor, constant: top).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: right).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom).isActive = true
    }
    
    func overlay(color: UIColor, alpha: CGFloat) {
        let overlay = UIView()
        overlay.backgroundColor = color
        overlay.alpha = alpha
        
        overlay.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(overlay)
        overlay.embed(in: self)
    }
    
}
