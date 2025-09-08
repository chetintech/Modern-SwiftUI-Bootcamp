//
//  ListItem.swift
//  MasterListApp
//
//  Created by Mehmet Emin Cetin on 8.09.2025.
//

import SwiftUI

struct ListItem: Identifiable, Codable {
    var id = UUID()
    var title: String
    var description: String
    var isCompleted: Bool
    var sfSymbol: String
    var color: Color {
        Color(red: Double.random(in: 0...1),
              green: Double.random(in: 0...1),
              blue: Double.random(in: 0...1))
    }
    
    init(title: String, description: String, isCompleted: Bool = false) {
        self.title = title
        self.description = description
        self.isCompleted = isCompleted
        self.sfSymbol = Self.randomSFSymbol()
    }
    
    private static func randomSFSymbol() -> String {
        let symbols = ["star.fill", "heart.fill", "bookmark.fill", "flag.fill",
                      "bell.fill", "house.fill", "person.fill", "gear",
                      "camera.fill", "message.fill", "phone.fill", "mail.fill",
                      "map.fill", "clock.fill", "calendar", "folder.fill"]
        return symbols.randomElement() ?? "star.fill"
    }
}

