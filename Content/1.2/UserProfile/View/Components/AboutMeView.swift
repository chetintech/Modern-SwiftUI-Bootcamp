//
//  AboutMeView.swift
//  UserProfile
//
//  Created by Mehmet Emin Çetin on 26.08.2025.
//

import SwiftUI

struct AboutMeView: View {
    let aboutText: String
    @State private var isExpanded = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header
            HStack {
                Text("Hakkımda")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                
                Spacer()
                
                if aboutText.count > 150 {
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            isExpanded.toggle()
                        }
                    }) {
                        Text(isExpanded ? "Daha Az" : "Daha Fazla")
                            .font(.caption)
                            .foregroundColor(.blue)
                            .fontWeight(.medium)
                    }
                }
            }
            
            // Content
            Text(aboutText)
                .font(.body)
                .foregroundColor(.secondary)
                .lineLimit(isExpanded ? nil : 3)
                .multilineTextAlignment(.leading)
                .animation(.easeInOut(duration: 0.3), value: isExpanded)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 2)
        )
    }
}

#Preview {
    AboutMeView(aboutText: User.sampleUser.aboutMe)
        .padding()
}
