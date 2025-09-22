//
//  AddNoteView.swift
//  Notepad
//
//  Created by Mehmet Emin Cetin on 12.09.2025.
//

import SwiftUI

struct AddNoteView: View {
    @ObservedObject var viewModel: NotesViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Başlık")
                        .font(.headline)
                    
                    TextField("Not başlığını girin...", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("İçerik")
                        .font(.headline)
                    
                    TextEditor(text: $content)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                        .frame(minHeight: 200)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Yeni Not")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("İptal") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Kaydet") {
                        saveNote()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
                             content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
            .alert("Boş Not", isPresented: $showingAlert) {
                Button("Tamam", role: .cancel) { }
            } message: {
                Text("Lütfen en az başlık veya içerik alanlarından birini doldurun.")
            }
        }
    }
    
    private func saveNote() {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedContent = content.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmedTitle.isEmpty && trimmedContent.isEmpty {
            showingAlert = true
            return
        }
        
        viewModel.addNote(title: trimmedTitle, content: trimmedContent)
        presentationMode.wrappedValue.dismiss()
    }
}
