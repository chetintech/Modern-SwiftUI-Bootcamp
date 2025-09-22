//
//  PostsViewModel.swift
//  Post
//
//  Created by Mehmet Emin Cetin on 22.09.2025.
//

import Foundation
import Combine

@MainActor
class PostsViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchText = ""
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol? = nil) {
        self.networkService = networkService ?? NetworkService()
    }
    
    var filteredPosts: [Post] {
        if searchText.isEmpty {
            return posts
        } else {
            return posts.filter { post in
                post.title.localizedCaseInsensitiveContains(searchText) ||
                post.body.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    func fetchPosts() async {
        isLoading = true
        errorMessage = nil
        
        do {
            posts = try await networkService.fetchPosts()
        } catch {
            errorMessage = (error as? NetworkError)?.localizedDescription ?? "An error occurred"
        }
        
        isLoading = false
    }
}

