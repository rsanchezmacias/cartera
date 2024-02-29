//
//  String+Extension.swift
//  Cartera
//
//  Created by Ricardo Sanchez-Macias on 2/29/24.
//

import UIKit

extension String {
    
    func width(withFont font: UIFont, height: CGFloat) -> CGFloat {
        let textAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font]
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        let boundingBox = (self as NSString).boundingRect(with: size, attributes: textAttributes, context: nil)
        return ceil(boundingBox.width)
    }
    
}
