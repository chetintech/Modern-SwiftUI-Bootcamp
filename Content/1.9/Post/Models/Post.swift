//
//  Post.swift
//  Post
//
//  Created by Mehmet Emin Cetin on 22.09.2025.
//

import Foundation

struct Post: Codable, Identifiable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}
