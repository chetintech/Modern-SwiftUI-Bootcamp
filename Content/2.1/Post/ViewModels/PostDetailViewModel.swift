//
//  PostDetailViewModel.swift
//  Post
//
//  Created by Mehmet Emin Cetin on 22.09.2025.
//

import Foundation
import Combine

@MainActor
class PostDetailViewModel: ObservableObject {
    @Published var post: Post?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol? = nil) {
        self.networkService = networkService ?? NetworkService()
    }
    
    func fetchPost(id: Int) async {
        isLoading = true
        errorMessage = nil
        
        do {
            post = try await networkService.fetchPost(id: id)
        } catch {
            errorMessage = (error as? NetworkError)?.localizedDescription ?? "An error occurred"
        }
        
        isLoading = false
    }
}
