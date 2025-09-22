//
//  ActionButtonsView.swift
//  UserProfile
//
//  Created by Mehmet Emin Çetin on 26.08.2025.
//

import SwiftUI

struct ActionButtonsView: View {
    let isFollowing: Bool
    let isLoading: Bool
    let followButtonText: String
    let onFollowTapped: () -> Void
    let onMessageTapped: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            // Message Button
            Button(action: onMessageTapped) {
                HStack(spacing: 6) {
                    Image(systemName: "message.fill")
                        .font(.system(size: 14, weight: .medium))
                    
                    Text("Mesaj")
                        .font(.system(size: 15, weight: .semibold))
                        .minimumScaleFactor(0.8)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                .foregroundColor(.blue)
                .background(
                    RoundedRectangle(cornerRadius: 22)
                        .stroke(Color.blue, lineWidth: 1.5)
                        .background(
                            RoundedRectangle(cornerRadius: 22)
                                .fill(Color.blue.opacity(0.05))
                        )
                )
            }
            .buttonStyle(ScaleButtonStyle())
            
            // Follow Button
            Button(action: onFollowTapped) {
                HStack(spacing: 6) {
                    if isLoading {
                        ProgressView()
                            .scaleEffect(0.8)
                            .foregroundColor(.white)
                    } else {
                        Image(systemName: isFollowing ? "person.fill.checkmark" : "person.fill.badge.plus")
                            .font(.system(size: 14, weight: .medium))
                        
                        Text(followButtonText)
                            .font(.system(size: 15, weight: .semibold))
                            .minimumScaleFactor(0.8)
                            .lineLimit(1)
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                .foregroundColor(.white)
                .background(
                    RoundedRectangle(cornerRadius: 22)
                        .fill(isFollowing ? Color.gray.opacity(0.8) : Color.blue)
                )
            }
            .disabled(isLoading)
            .buttonStyle(ScaleButtonStyle())
            .opacity(isLoading ? 0.7 : 1.0)
        }
    }
}

// Custom button style for press animation
struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

#Preview {
    VStack(spacing: 20) {
        ActionButtonsView(
            isFollowing: false,
            isLoading: false,
            followButtonText: "Takip Et",
            onFollowTapped: {},
            onMessageTapped: {}
        )
        
        ActionButtonsView(
            isFollowing: true,
            isLoading: false,
            followButtonText: "Takip Ediliyor",
            onFollowTapped: {},
            onMessageTapped: {}
        )
        
        ActionButtonsView(
            isFollowing: false,
            isLoading: true,
            followButtonText: "Takip Et",
            onFollowTapped: {},
            onMessageTapped: {}
        )
    }
    .padding()
}
