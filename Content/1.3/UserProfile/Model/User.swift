//
//  UserProfileModel.swift
//  UserProfile
//
//  Created by Mehmet Emin Çetin on 25.08.2025.
//

import Foundation

// MARK: - User Model
struct User {
    let id: String
    let name: String
    let description: String
    let profileImageName: String
    let followersCount: Int
    let followingCount: Int
    let likesCount: Int
    let aboutMe: String
    let isFollowing: Bool
    
    // Sample data
    static let sampleUser = User(
        id: "1",
        name: "Mehmet Emin Çetin",
        description: "iOS Developer & UI/UX Designer",
        profileImageName: "person.circle.fill",
        followersCount: 1250,
        followingCount: 845,
        likesCount: 3420,
        aboutMe: "Merhaba! Ben bir iOS geliştiricisiyim ve mobil uygulama geliştirme konusunda tutkulu bir yazılımcıyım. SwiftUI ile modern ve kullanıcı dostu arayüzler tasarlamayı seviyorum. Boş zamanlarımda yeni teknolojileri öğrenmeyi ve açık kaynak projelere katkıda bulunmayı seviyorum.",
        isFollowing: false
    )
}

// MARK: - Stats Model
struct UserStats {
    let followers: Int
    let following: Int
    let likes: Int
}

// MARK: - User Action Types
enum UserAction {
    case follow
    case unfollow
    case sendMessage
}
