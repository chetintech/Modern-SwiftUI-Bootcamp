//
//  EvenViewModel.swift
//  Event
//
//  Created by Mehmet Emin Cetin on 12.09.2025.
//

import Foundation
import SwiftUI

class EventViewModel: ObservableObject {
    @Published var events: [Event] = []
    
    init() {
        loadSampleData()
    }
    
    // MARK: - CRUD Operations
    func addEvent(_ event: Event) {
        events.append(event)
        events.sort { $0.date < $1.date }
    }
    
    func deleteEvent(at indexSet: IndexSet) {
        events.remove(atOffsets: indexSet)
    }
    
    func deleteEvent(_ event: Event) {
        events.removeAll { $0.id == event.id }
    }
    
    func updateEvent(_ event: Event) {
        if let index = events.firstIndex(where: { $0.id == event.id }) {
            events[index] = event
            events.sort { $0.date < $1.date }
        }
    }
    
    func toggleReminder(for event: Event) {
        if let index = events.firstIndex(where: { $0.id == event.id }) {
            events[index].hasReminder.toggle()
        }
    }
    
    // MARK: - Sample Data
    private func loadSampleData() {
        let calendar = Calendar.current
        let today = Date()
        
        events = [
            Event(title: "Ali'nin Doğum Günü",
                  date: calendar.date(byAdding: .day, value: 5, to: today) ?? today,
                  type: .birthday,
                  hasReminder: true),
            Event(title: "Proje Toplantısı",
                  date: calendar.date(byAdding: .day, value: 2, to: today) ?? today,
                  type: .meeting,
                  hasReminder: true),
            Event(title: "Yaz Tatili",
                  date: calendar.date(byAdding: .month, value: 2, to: today) ?? today,
                  type: .vacation,
                  hasReminder: false)
        ]
        
        events.sort { $0.date < $1.date }
    }
}
