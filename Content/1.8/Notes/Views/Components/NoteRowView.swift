//
//  NoteRowView.swift
//  Notes
//
//  Created by Mehmet Emin Cetin on 22.09.2025.
//

import SwiftUI

struct NoteRowView: View {
    let note: Note
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(note.wrappedTitle)
                .font(.headline)
                .lineLimit(1)
            
            Text(note.wrappedContent)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(2)
            
            Text(note.wrappedDate, style: .date)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 2)
    }
}

