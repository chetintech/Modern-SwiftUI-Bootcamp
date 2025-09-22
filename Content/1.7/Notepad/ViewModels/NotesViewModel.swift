//
//  NotesViewModel.swift
//  Notepad
//
//  Created by Mehmet Emin Cetin on 12.09.2025.
//

import Foundation
import Combine

class NotesViewModel: ObservableObject {
    @Published var notes: [Note] = []
    @Published var searchText: String = ""
    
    private let repository: UserDefaultsManagerProtocol
    
    init(repository: UserDefaultsManagerProtocol = UserDefaultsManager()) {
        self.repository = repository
        loadNotes()
    }
    
    var filteredNotes: [Note] {
        if searchText.isEmpty {
            return notes.sorted { $0.date > $1.date }
        } else {
            return notes.filter { note in
                note.title.localizedCaseInsensitiveContains(searchText) ||
                note.content.localizedCaseInsensitiveContains(searchText)
            }.sorted { $0.date > $1.date }
        }
    }
    
    func addNote(title: String, content: String) {
        let newNote = Note(title: title, content: content)
        notes.append(newNote)
        saveNotes()
    }
    
    func deleteNote(at indexSet: IndexSet) {
        let sortedNotes = filteredNotes
        for index in indexSet {
            if let noteIndex = notes.firstIndex(where: { $0.id == sortedNotes[index].id }) {
                notes.remove(at: noteIndex)
            }
        }
        saveNotes()
    }
    
    func deleteNote(note: Note) {
        notes.removeAll { $0.id == note.id }
        saveNotes()
    }
    
    private func loadNotes() {
        notes = repository.loadNotes()
    }
    
    private func saveNotes() {
        repository.saveNotes(notes)
    }
}
