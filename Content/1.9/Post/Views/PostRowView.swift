//
//  PostRowView.swift
//  Post
//
//  Created by Mehmet Emin Cetin on 22.09.2025.
//

import SwiftUI

struct PostRowView: View {
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "book.fill").foregroundColor(.accentColor)
                Text(post.title)
                    .font(.headline)
                    .lineLimit(2)
            }
            Text(post.body)
                .font(.body)
                .foregroundColor(.secondary)
                .lineLimit(3)
            HStack {
                Image(systemName: "number.circle")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                Text("ID: \(post.id)")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                Spacer()
                Image(systemName: "person.crop.circle")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                Text("User: \(post.userId)")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: .black.opacity(0.05), radius: 2, y: 2)
        .padding(.vertical, 8)
    }
}
