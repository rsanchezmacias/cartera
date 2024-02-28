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
