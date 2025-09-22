//
//  NetworkService.swift
//  Post
//
//  Created by Mehmet Emin Cetin on 22.09.2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case networkError(Error)
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data received"
        case .decodingError:
            return "Failed to decode data"
        case .networkError(let error):
            return error.localizedDescription
        }
    }
}

protocol NetworkServiceProtocol {
    func fetchPosts() async throws -> [Post]
    func fetchPost(id: Int) async throws -> Post
}

class NetworkService: NetworkServiceProtocol {
    private let baseURL = "https://jsonplaceholder.typicode.com"
    
    func fetchPosts() async throws -> [Post] {
        guard let url = URL(string: "\(baseURL)/posts") else {
            throw NetworkError.invalidURL
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let posts = try JSONDecoder().decode([Post].self, from: data)
            return posts
        } catch {
            if error is DecodingError {
                throw NetworkError.decodingError
            } else {
                throw NetworkError.networkError(error)
            }
        }
    }
    
    func fetchPost(id: Int) async throws -> Post {
        guard let url = URL(string: "\(baseURL)/posts/\(id)") else {
            throw NetworkError.invalidURL
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let post = try JSONDecoder().decode(Post.self, from: data)
            return post
        } catch {
            if error is DecodingError {
                throw NetworkError.decodingError
            } else {
                throw NetworkError.networkError(error)
            }
        }
    }
}
