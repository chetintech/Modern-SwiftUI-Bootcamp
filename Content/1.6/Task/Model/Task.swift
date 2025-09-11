//
//  Task.Swift
//  Task
//
//  Created by Mehmet Emin Cetin on 11.09.2025.
//

import Foundation

// MARK: - Task Model
struct Task: Identifiable, Codable {
    let id: UUID
    var title: String
    var isCompleted: Bool
    let createdAt: Date
    
    // Varsayılan başlatıcı
    init(title: String, isCompleted: Bool = false) {
        self.id = UUID()
        self.title = title
        self.isCompleted = isCompleted
        self.createdAt = Date()
    }
    
    // Tüm parametrelerle başlatıcı
    init(id: UUID, title: String, isCompleted: Bool, createdAt: Date) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.createdAt = createdAt
    }
}

// MARK: - Task Extension
extension Task {
    // Örnek görevler
    static let sampleTasks = [
        Task(title: "SwiftUI öğren"),
        Task(title: "MVVM mimarisini anla"),
        Task(title: "Görev yönetim uygulaması yap", isCompleted: true)
    ]
}
