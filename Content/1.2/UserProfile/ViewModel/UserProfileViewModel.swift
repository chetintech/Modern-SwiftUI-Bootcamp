//
//  UserProfileViewModel.swift
//  UserProfile
//
//  Created by Mehmet Emin Çetin on 25.08.2025.
//

import Foundation
import Combine

// MARK: - User Profile ViewModel
class UserProfileViewModel: ObservableObject {
    @Published var user: User
    @Published var isLoading: Bool = false
    @Published var showMessageAlert: Bool = false
    
    init(user: User = User.sampleUser) {
        self.user = user
    }
    
    // MARK: - User Actions
    func followUser() {
        isLoading = true
        
        // Simulate API call
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            
            self.user = User(
                id: self.user.id,
                name: self.user.name,
                description: self.user.description,
                profileImageName: self.user.profileImageName,
                followersCount: self.user.isFollowing ? self.user.followersCount - 1 : self.user.followersCount + 1,
                followingCount: self.user.followingCount,
                likesCount: self.user.likesCount,
                aboutMe: self.user.aboutMe,
                isFollowing: !self.user.isFollowing
            )
            
            self.isLoading = false
        }
    }
    
    func sendMessage() {
        showMessageAlert = true
    }
    
    // MARK: - Computed Properties
    var formattedFollowersCount: String {
        return formatNumber(user.followersCount)
    }
    
    var formattedFollowingCount: String {
        return formatNumber(user.followingCount)
    }
    
    var formattedLikesCount: String {
        return formatNumber(user.likesCount)
    }
    
    var followButtonText: String {
        return user.isFollowing ? "Takip Ediliyor" : "Takip Et"
    }
    
    private func formatNumber(_ number: Int) -> String {
        if number >= 1000 {
            let thousands = Double(number) / 1000.0
            return String(format: "%.1fK", thousands)
        }
        return "\(number)"
    }
}
