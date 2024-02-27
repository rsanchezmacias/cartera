//
//  UIViewController+Extension.swift
//  Cartera
//
//  Created by Ricardo Sanchez-Macias on 2/26/24.
//

import UIKit

extension UIViewController {
    
    class func instantiateFrom(storyboardName: String, identifier: String? = nil) -> Self? {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        
        if let identifier = identifier {
            return storyboard.instantiateViewController(withIdentifier: identifier) as? Self
        } else {
            return storyboard.instantiateInitialViewController() as? Self
        }
    }
    
}
