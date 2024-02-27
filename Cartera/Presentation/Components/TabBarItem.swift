//
//  TabBarView.swift
//  Cartera
//
//  Created by Ricardo Sanchez-Macias on 2/26/24.
//

import UIKit

class TabBarItem: UITabBarItem {
    
    convenience init(title: String?, image: UIImage?, tag: Int) {
        self.init()
        self.setup(title: title, image: image, tag: tag)
    }
    
    override init() {
        super.init()
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup(title: String? = nil, image: UIImage? = nil, tag: Int = 0) {
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        
        self.title = title
        self.image = image?.withRenderingMode(.alwaysOriginal)
        self.selectedImage = image?.withTintColor(.black, renderingMode: .alwaysOriginal)
        self.tag = tag
    }
    
}
