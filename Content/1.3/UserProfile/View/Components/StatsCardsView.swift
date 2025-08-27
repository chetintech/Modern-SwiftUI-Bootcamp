//
//  StatsCardsView.swift
//  UserProfile
//
//  Created by Mehmet Emin Çetin on 26.08.2025.
//

import SwiftUI

struct StatsCardsView: View {
    let followersCount: String
    let followingCount: String
    let likesCount: String
    
    var body: some View {
        LazyHGrid(rows: [GridItem(.flexible())], spacing: 12) {
            StatCard(
                title: "Takipçi",
                value: followersCount,
                icon: "person.2.fill",
                color: .blue
            )
            
            StatCard(
                title: "Takip",
                value: followingCount,
                icon: "person.badge.plus.fill",
                color: .green
            )
            
            StatCard(
                title: "Beğeni",
                value: likesCount,
                icon: "heart.fill",
                color: .red
            )
        }
        .padding(.horizontal, 4)
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(color)
                .frame(height: 20)
            
            Text(value)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .minimumScaleFactor(0.8)
                .lineLimit(1)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .padding(.horizontal, 8)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 2)
        )
    }
}

#Preview {
    StatsCardsView(
        followersCount: "1.2K",
        followingCount: "845",
        likesCount: "3.4K"
    )
    .padding()
}
