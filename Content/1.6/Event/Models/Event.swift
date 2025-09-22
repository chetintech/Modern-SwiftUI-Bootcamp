//
//  Event.swift
//  Event
//
//  Created by Mehmet Emin Cetin on 12.09.2025.
//

import Foundation

struct Event: Identifiable, Codable {
    let id = UUID()
    var title: String
    var date: Date
    var type: EventType
    var hasReminder: Bool
    
    init(title: String, date: Date, type: EventType, hasReminder: Bool = false) {
        self.title = title
        self.date = date
        self.type = type
        self.hasReminder = hasReminder
    }
}

enum EventType: String, CaseIterable, Codable {
    case birthday = "Doğum Günü"
    case meeting = "Toplantı"
    case vacation = "Tatil"
    case sport = "Spor"
    case other = "Diğer"
    
    var displayName: String {
        return self.rawValue
    }
    
    var emoji: String {
        switch self {
        case .birthday: return "🎂"
        case .meeting: return "📅"
        case .vacation: return "🏖️"
        case .sport: return "⚽"
        case .other: return "📝"
        }
    }
}
