//
//  HeaderView.swift
//  UserProfile
//
//  Created by Mehmet Emin Çetin on 26.08.2025.
//

import SwiftUI

struct HeaderView: View {
    let user: User
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Gradient Background
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.blue.opacity(0.8),
                        Color.purple.opacity(0.6),
                        Color.pink.opacity(0.4)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                
                VStack(spacing: 12) {
                    Spacer(minLength: 60) // Safe area spacing
                    
                    // Profile Image
                    Image(systemName: user.profileImageName)
                        .font(.system(size: min(geometry.size.width * 0.15, 80)))
                        .foregroundColor(.white)
                        .frame(
                            width: min(geometry.size.width * 0.25, 120),
                            height: min(geometry.size.width * 0.25, 120)
                        )
                        .background(
                            Circle()
                                .fill(Color.white.opacity(0.2))
                                .overlay(
                                    Circle()
                                        .stroke(Color.white, lineWidth: 3)
                                )
                        )
                        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                    
                    // User Name
                    Text(user.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .minimumScaleFactor(0.8)
                        .lineLimit(1)
                    
                    // User Description
                    Text(user.description)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .padding(.horizontal, 20)
                    
                    Spacer(minLength: 16)
                }
                .frame(width: geometry.size.width)
            }
        }
        .frame(height: 260)
    }
}

#Preview {
    HeaderView(user: User.sampleUser)
}
