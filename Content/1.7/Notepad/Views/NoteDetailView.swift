//
//  NoteDetailView.swift
//  Notepad
//
//  Created by Mehmet Emin Cetin on 12.09.2025.
//

import SwiftUI

struct NoteDetailView: View {
    let note: Note
    @ObservedObject var viewModel: NotesViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(note.date, style: .date)
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        Text(note.date, style: .time)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    if !note.title.isEmpty {
                        Text(note.title)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                }
                
                Divider()
                
                if !note.content.isEmpty {
                    Text(note.content)
                        .font(.body)
                        .lineSpacing(4)
                } else {
                    Text("İçerik yok")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .italic()
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle(note.title.isEmpty ? "Not Detayı" : "")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showingDeleteAlert = true
                } label: {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
            }
        }
        .alert("Notu Sil", isPresented: $showingDeleteAlert) {
            Button("İptal", role: .cancel) { }
            Button("Sil", role: .destructive) {
                viewModel.deleteNote(note: note)
                presentationMode.wrappedValue.dismiss()
            }
        } message: {
            Text("Bu notu silmek istediğinizden emin misiniz? Bu işlem geri alınamaz.")
        }
    }
}
