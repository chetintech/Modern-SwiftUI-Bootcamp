//
//  NotesListView.swift
//  Notes
//
//  Created by Mehmet Emin Cetin on 22.09.2025.
//

import SwiftUI
import CoreData

struct NotesListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var viewModel = NotesViewModel()
    @State private var showingAddNote = false
    @State private var searchText = ""
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Note.date, ascending: false)],
        animation: .default)
    private var notes: FetchedResults<Note>
    
    var filteredNotes: [Note] {
        if searchText.isEmpty {
            return Array(notes)
        } else {
            return notes.filter { note in
                note.wrappedTitle.localizedCaseInsensitiveContains(searchText) ||
                note.wrappedContent.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if filteredNotes.isEmpty {
                    EmptyStateView()
                } else {
                    List {
                        ForEach(filteredNotes, id: \.wrappedID) { note in
                            NavigationLink(destination: NoteDetailView(note: note)) {
                                NoteRowView(note: note)
                            }
                        }
                        .onDelete(perform: deleteNotes)
                    }
                }
            }
            .navigationTitle("Notes")
            .searchable(text: $searchText, prompt: "Search notes...")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddNote = true }) {
                        Image(systemName: "plus")
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddNote) {
                AddNoteView()
            }
        }
    }
    
    private func deleteNotes(offsets: IndexSet) {
        viewModel.deleteNotes(at: offsets, from: filteredNotes)
    }
}
