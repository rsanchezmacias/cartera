//
//  ImageDownloadService.swift
//  Cartera
//
//  Created by Ricardo Sanchez-Macias on 3/25/24.
//

import UIKit
import Combine

protocol ImageDownloadServiceProtocol {
    
    func downloadImage(url: String) async throws -> UIImage
    
}

class ImageDownloadService: ImageDownloadServiceProtocol {
    
    private var subscriptions: Set<AnyCancellable> = []
    
    func downloadImage(url: String) async throws -> UIImage {
        guard let completeURL = URL(string: url) else {
            throw CarteraError.urlError
        }
        
        let (data, response) = try await URLSession.shared.data(for: URLRequest(url: completeURL))
        
        guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
            throw CarteraError.networkError
        }
        
        guard let image = UIImage(data: data) else {
            throw CarteraError.dataError
        }
        
        return image
    }
    
}
