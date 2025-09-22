//
//  Note.swift
//  Notepad
//
//  Created by Mehmet Emin Cetin on 12.09.2025.
//

import Foundation

struct Note: Codable, Identifiable {
    let id: UUID
    var title: String
    var content: String
    let date: Date
    
    init(title: String, content: String) {
        self.id = UUID()
        self.title = title
        self.content = content
        self.date = Date()
    }
}

