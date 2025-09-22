//
//  NoteDetailView.swift
//  Notes
//
//  Created by Mehmet Emin Cetin on 22.09.2025.
//

import SwiftUI

struct NoteDetailView: View {
    @ObservedObject var note: Note
    @StateObject private var viewModel = NotesViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var isEditing = false
    @State private var showingDeleteAlert = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if isEditing {
                TextField("Note title", text: $title)
                    .font(.title2)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Text("Content")
                    .font(.headline)
                
                TextEditor(text: $content)
                    .font(.body)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
            } else {
                Text(note.wrappedTitle)
                    .font(.title2)
                    .fontWeight(.bold)
                
                ScrollView {
                    Text(note.wrappedContent)
                        .font(.body)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text("Created: \(note.wrappedDate, formatter: dateFormatter)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    if isEditing {
                        Button("Save") {
                            viewModel.updateNote(note, title: title, content: content)
                            isEditing = false
                        }
                    } else {
                        Button("Edit") {
                            title = note.wrappedTitle
                            content = note.wrappedContent
                            isEditing = true
                        }
                    }
                    
                    Button(action: { showingDeleteAlert = true }) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                }
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                if isEditing {
                    Button("Cancel") {
                        isEditing = false
                        title = note.wrappedTitle
                        content = note.wrappedContent
                    }
                }
            }
        }
        .alert("Delete Note", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive) {
                viewModel.deleteNote(note)
                presentationMode.wrappedValue.dismiss()
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure you want to delete this note? This action cannot be undone.")
        }
        .onAppear {
            title = note.wrappedTitle
            content = note.wrappedContent
        }
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
}

// MARK: - Empty State View
struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "note.text")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            Text("No Notes Yet")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Tap the + button to create your first note")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}
