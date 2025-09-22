//
//  PostsListView.swift
//  Post
//
//  Created by Mehmet Emin Cetin on 22.09.2025.
//

import SwiftUI

struct PostsListView: View {
    @StateObject private var viewModel = PostsViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchText)
                
                if viewModel.isLoading {
                    ProgressView("Loading posts...")
                        .tint(.accentColor)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let errorMessage = viewModel.errorMessage {
                    ErrorView(message: errorMessage) {
                        Task {
                            await viewModel.fetchPosts()
                        }
                    }
                } else {
                    List(viewModel.filteredPosts) { post in
                        NavigationLink(destination: PostDetailView(postId: post.id)) {
                            PostRowView(post: post)
                        }
                        .listRowBackground(Color.clear)
                    }
                    .listStyle(.plain)
                    .refreshable {
                        await viewModel.fetchPosts()
                    }
                }
                Spacer(minLength: 8)
            }
            .padding(.horizontal)
            .background(.clear)
            .navigationTitle("Posts")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Label("Posts", systemImage: "books.vertical")
                        .labelStyle(.titleAndIcon)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await viewModel.fetchPosts()
            }
        }
    }
}
