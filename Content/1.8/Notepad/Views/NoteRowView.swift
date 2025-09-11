//
//  NoteRowView.swift
//  Notepad
//
//  Created by Mehmet Emin Cetin on 12.09.2025.
//

import SwiftUI

struct NoteRowView: View {
    let note: Note
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(note.title.isEmpty ? "Başlıksız Not" : note.title)
                    .font(.headline)
                    .lineLimit(1)
                
                Spacer()
                
                Text(note.date, style: .date)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            if !note.content.isEmpty {
                Text(note.content)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
        }
        .padding(.vertical, 2)
    }
}
