//
//  PostDetailView.swift
//  Post
//
//  Created by Mehmet Emin Cetin on 22.09.2025.
//

import SwiftUI

struct PostDetailView: View {
    let postId: Int
    @StateObject private var viewModel = PostDetailViewModel()
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Loading post details...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let errorMessage = viewModel.errorMessage {
                ErrorView(message: errorMessage) {
                    Task {
                        await viewModel.fetchPost(id: postId)
                    }
                }
            } else if let post = viewModel.post {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        HStack(spacing: 8) {
                            Image(systemName: "doc.text.magnifyingglass")
                                .font(.title2)
                                .foregroundColor(.accentColor)
                            Text("Post Details")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        
                        HStack {
                            Image(systemName: "number.circle")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text("ID: \(post.id)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            Spacer()
                            
                            Image(systemName: "person.crop.circle")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text("User ID: \(post.userId)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Divider()
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Title")
                                .font(.headline)
                            Text(post.title)
                                .font(.title3)
                                .fontWeight(.medium)
                                .foregroundStyle(.primary)
                        }
                        
                        Divider()
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Content")
                                .font(.headline)
                            Text(post.body)
                                .font(.body)
                                .foregroundStyle(.secondary)
                                .lineSpacing(4)
                        }
                    }
                    .padding()
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                    .shadow(color: .black.opacity(0.07), radius: 8, y: 4)
                    .padding()
                    .padding(.bottom, 32)
                }
            } else {
                Text("Post not found")
                    .foregroundColor(.secondary)
            }
        }
        .navigationTitle("Post \(postId)")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.fetchPost(id: postId)
        }
    }
}
