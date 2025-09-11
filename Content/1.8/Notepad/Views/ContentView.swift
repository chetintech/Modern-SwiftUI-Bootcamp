//
//  ContentView.swift
//  Notepad
//
//  Created by Mehmet Emin Cetin on 12.09.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = NotesViewModel()
    @State private var showingAddNoteSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.notes.isEmpty {
                    EmptyStateView()
                } else {
                    NotesListView(viewModel: viewModel)
                }
            }
            .navigationTitle("Notlarım")
            .searchable(text: $viewModel.searchText, prompt: "Notlarda ara...")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddNoteSheet = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $showingAddNoteSheet) {
                AddNoteView(viewModel: viewModel)
            }
        }
    }
}
