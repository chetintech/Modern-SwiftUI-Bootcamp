//
//  AddNoteView.swift
//  Notes
//
//  Created by Mehmet Emin Cetin on 22.09.2025.
//

import SwiftUI

struct AddNoteView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = NotesViewModel()
    
    @State private var title = ""
    @State private var content = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
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
                
                Spacer()
            }
            .padding()
            .navigationTitle("New Note")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        viewModel.addNote(title: title, content: content)
                        presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(title.isEmpty && content.isEmpty)
                }
            }
        }
    }
}
