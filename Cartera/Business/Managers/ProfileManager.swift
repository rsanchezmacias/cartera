//
//  ProfileManager.swift
//  Cartera
//
//  Created by Ricardo Sanchez-Macias on 2/27/24.
//

import UIKit
import Combine

protocol ProfileManagerProtocol {
    
    var userInfo: UserInfo! { get }
    var userImage: UIImage? { get }
    
    func getUserImage() -> AnyPublisher<UIImage?, Never>
    func getUserInfo() -> AnyPublisher<UserInfo, Error>
    
}

class ProfileManager: ProfileManagerProtocol, ObservableObject {
    
    struct Constants {
        static let userInfoFilename: String = "profile.json"
        static let userImageName: String = "profile_image.jpeg"
    }
    
    private(set) var userInfo: UserInfo!
    private(set) var userImage: UIImage?
    
    init() {
        userInfo = JSONParser.decode(filename: Self.Constants.userInfoFilename, type: UserInfo.self)
        
        if let userImagePath = Bundle.main.path(forResource: Self.Constants.userImageName, ofType: nil) {
            userImage = UIImage(contentsOfFile: userImagePath)
        }
    }
    
    func getUserInfo() -> AnyPublisher<UserInfo, Error> {
        return Future { [weak self] promise in
            guard let self = self else { return }
            promise(.success(self.userInfo))
        }.eraseToAnyPublisher()
    }
    
    func getUserImage() -> AnyPublisher<UIImage?, Never> {
        return Future { [weak self] promise in
            promise(.success(self?.userImage))
        }.eraseToAnyPublisher()
    }
    
}
