//
//  NotesListView.swift
//  Notepad
//
//  Created by Mehmet Emin Cetin on 12.09.2025.
//

import SwiftUI

struct NotesListView: View {
    @ObservedObject var viewModel: NotesViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.filteredNotes) { note in
                NavigationLink(destination: NoteDetailView(note: note, viewModel: viewModel)) {
                    NoteRowView(note: note)
                }
            }
            .onDelete(perform: viewModel.deleteNote)
        }
        .listStyle(InsetGroupedListStyle())
    }
}
