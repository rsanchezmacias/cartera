//
//  ProfileViewModel.swift
//  Cartera
//
//  Created by Ricardo Sanchez-Macias on 2/27/24.
//

import UIKit
import Combine

class ProfileViewModel: ObservableObject {
    
    @Published private var profileManager: ProfileManagerProtocol!
    
    @Published var userName: String?
    @Published var userPosition: String?
    @Published var userLocation: String?
    @Published var userDescription: String?
    @Published var userImage: UIImage?
    
    private var subscriptions: [AnyCancellable] = []
    
    init() {
        profileManager = Container.shared.profileManager
        
        subscribe()
    }
    
    private func subscribe() {
        profileManager.getUserInfo()
            .receive(on: RunLoop.main)
            .sink { _ in
                // Handle subscription completion
            } receiveValue: { [weak self] userInfo in
                self?.userName = userInfo.fullName
                self?.userPosition = userInfo.position
                self?.userLocation = userInfo.location
                self?.userDescription = userInfo.description
            }
            .store(in: &subscriptions)
        
        profileManager.getUserImage()
            .receive(on: RunLoop.main)
            .sink { [weak self] image in
                self?.userImage = image
            }
            .store(in: &subscriptions)
    }
    
}
