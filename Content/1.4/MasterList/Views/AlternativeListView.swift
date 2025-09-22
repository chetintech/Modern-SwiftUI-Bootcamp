//
//  AlternativeListView.swift
//  MasterListApp
//
//  Created by Mehmet Emin Cetin on 8.09.2025.
//

import SwiftUI

struct AlternativeListView: View {
    @StateObject private var viewModel = ListViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 0) {
                    // Pending Section
                    if !viewModel.pendingItems.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("Tamamlanacaklar")
                                    .font(.headline)
                                    .foregroundColor(viewModel.themeColor)
                                Spacer()
                            }
                            .padding(.horizontal)
                            
                            ForEach(viewModel.pendingItems) { item in
                                NavigationLink(destination: DetailView(item: item, viewModel: viewModel)) {
                                    AlternativeRowView(item: item, themeColor: viewModel.themeColor)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.vertical)
                    }
                    
                    // Completed Section
                    if !viewModel.completedItems.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("Tamamlananlar")
                                    .font(.headline)
                                    .foregroundColor(viewModel.themeColor)
                                Spacer()
                            }
                            .padding(.horizontal)
                            
                            ForEach(viewModel.completedItems) { item in
                                NavigationLink(destination: DetailView(item: item, viewModel: viewModel)) {
                                    AlternativeRowView(item: item, themeColor: viewModel.themeColor)
                                        .opacity(0.7)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.vertical)
                    }
                }
            }
            .navigationTitle("MasterList Alt")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}
