//
//  AppTab.swift
//  Cartera
//
//  Created by Ricardo Sanchez-Macias on 2/26/24.
//

import Foundation

enum AppTab: String, CaseIterable {
    
    case profile
    case education
    case work

    var viewControllerName: String {
        switch self {
        case .profile:
            return "ProfileViewController"
        case .education:
            return "EducationViewController"
        case .work:
            return "WorkViewController"
        }
    }

    var tabBarTitle: String {
        switch self {
        case .profile:
            return "Profile"
        case .education:
            return "Education"
        case .work:
            return "Jobs"
        }
    }

    var tabBarImageName: String {
        switch self {
        case .profile:
            return "person.crop.circle"
        case .education:
            return "graduationcap"
        case .work:
            return "suitcase"
        }
    }

    var tabBarID: Int {
        switch self {
        case .profile:
            return 0
        case .education:
            return 1
        case .work:
            return 2
        }
    }
    
}
