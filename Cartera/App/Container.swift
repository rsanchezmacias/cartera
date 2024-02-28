//
//  Container.swift
//  Cartera
//
//  Created by Ricardo Sanchez-Macias on 2/27/24.
//

import Foundation

class Container {
    
    static let shared = Container()
    
    private(set) var profileManager: ProfileManagerProtocol!
    
    func setup() {
        profileManager = ProfileManager()
    }
    
}
