//
//  NotesViewModel.swift
//  Notes
//
//  Created by Mehmet Emin Cetin on 22.09.2025.
//

import Foundation
import CoreData
import SwiftUI
import Combine

class NotesViewModel: ObservableObject {
    private let coreDataManager = CoreDataManager.shared
    
    func addNote(title: String, content: String) {
        let context = coreDataManager.viewContext
        let newNote = Note(context: context)
        
        newNote.id = UUID()
        newNote.title = title.isEmpty ? "Untitled" : title
        newNote.content = content
        newNote.date = Date()
        
        coreDataManager.save()
    }
    
    func updateNote(_ note: Note, title: String, content: String) {
        note.title = title.isEmpty ? "Untitled" : title
        note.content = content
        note.date = Date()
        
        coreDataManager.save()
    }
    
    func deleteNote(_ note: Note) {
        let context = coreDataManager.viewContext
        context.delete(note)
        coreDataManager.save()
    }
    
    func deleteNotes(at offsets: IndexSet, from notes: [Note]) {
        let context = coreDataManager.viewContext
        
        for index in offsets {
            context.delete(notes[index])
        }
        
        coreDataManager.save()
    }
}
