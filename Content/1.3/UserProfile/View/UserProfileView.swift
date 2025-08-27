//
//  UserProfileView.swift
//  UserProfile
//
//  Created by Mehmet Emin Çetin on 26.08.2025.
//

import SwiftUI

struct UserProfileView: View {
    @StateObject private var viewModel = UserProfileViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVStack(spacing: 0) {
                    // Header Section
                    HeaderView(user: viewModel.user)
                    
                    // Content Section
                    VStack(spacing: 20) {
                        // Stats Cards
                        StatsCardsView(
                            followersCount: viewModel.formattedFollowersCount,
                            followingCount: viewModel.formattedFollowingCount,
                            likesCount: viewModel.formattedLikesCount
                        )
                        .padding(.top, 16)
                        
                        // About Me Section
                        AboutMeView(aboutText: viewModel.user.aboutMe)
                        
                        // Action Buttons
                        ActionButtonsView(
                            isFollowing: viewModel.user.isFollowing,
                            isLoading: viewModel.isLoading,
                            followButtonText: viewModel.followButtonText,
                            onFollowTapped: viewModel.followUser,
                            onMessageTapped: viewModel.sendMessage
                        )
                        .padding(.bottom, 20)
                    }
                    .padding(.horizontal, 16)
                    .frame(maxWidth: .infinity)
                }
            }
            .ignoresSafeArea(edges: .top)
        }
        .alert("Mesaj", isPresented: $viewModel.showMessageAlert) {
            Button("Tamam") { }
        } message: {
            Text("Mesaj gönderme özelliği yakında eklenecek!")
        }
    }
}

#Preview {
    UserProfileView()
}

