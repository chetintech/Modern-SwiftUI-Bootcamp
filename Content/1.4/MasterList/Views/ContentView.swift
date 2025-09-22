//
//  ContentView.swift
//  MasterListApp
//
//  Created by Mehmet Emin Cetin on 8.09.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ListViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [viewModel.themeColor.opacity(0.1), Color.white]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                List {
                    if !viewModel.pendingItems.isEmpty {
                        Section(header: Text("Tamamlanacaklar")
                            .font(.headline)
                            .foregroundColor(viewModel.themeColor)) {
                            ForEach(viewModel.pendingItems) { item in
                                NavigationLink(destination: DetailView(item: item, viewModel: viewModel)) {
                                    ListRowView(item: item, themeColor: viewModel.themeColor)
                                }
                            }
                            .onDelete { indexSet in
                                let itemsToDelete = indexSet.map { viewModel.pendingItems[$0] }
                                for item in itemsToDelete {
                                    if let index = viewModel.items.firstIndex(where: { $0.id == item.id }) {
                                        viewModel.items.remove(at: index)
                                    }
                                }
                            }
                        }
                    }
                    
                    if !viewModel.completedItems.isEmpty {
                        Section(header: Text("Tamamlananlar")
                            .font(.headline)
                            .foregroundColor(viewModel.themeColor)) {
                            ForEach(viewModel.completedItems) { item in
                                NavigationLink(destination: DetailView(item: item, viewModel: viewModel)) {
                                    ListRowView(item: item, themeColor: viewModel.themeColor)
                                        .opacity(0.7)
                                }
                            }
                            .onDelete { indexSet in
                                let itemsToDelete = indexSet.map { viewModel.completedItems[$0] }
                                for item in itemsToDelete {
                                    if let index = viewModel.items.firstIndex(where: { $0.id == item.id }) {
                                        viewModel.items.remove(at: index)
                                    }
                                }
                            }
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .navigationTitle("MasterList")
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            viewModel.showingAddSheet = true
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(viewModel.themeColor)
                                .font(.title2)
                        }
                    }
                }
                .sheet(isPresented: $viewModel.showingAddSheet) {
                    AddItemSheet(viewModel: viewModel)
                }
            }
        }
        .onAppear {
            // Her açılışta rastgele tema rengi ayarla
            let colors: [Color] = [.blue, .green, .purple, .orange, .red, .pink, .cyan, .mint]
            viewModel.themeColor = colors.randomElement() ?? .blue
        }
    }
}
