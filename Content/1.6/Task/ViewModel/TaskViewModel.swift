//
//  TaskViewModel.swift
//  Task
//
//  Created by Mehmet Emin Cetin on 11.09.2025.
//

import Foundation
import Combine

// MARK: - Task ViewModel
class TaskViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var tasks: [Task] = []
    @Published var newTaskTitle: String = ""
    
    // MARK: - Computed Properties
    var activeTasks: [Task] {
        tasks.filter { !$0.isCompleted }
    }
    
    var completedTasks: [Task] {
        tasks.filter { $0.isCompleted }
    }
    
    var activeTaskCount: Int {
        activeTasks.count
    }
    
    var completedTaskCount: Int {
        completedTasks.count
    }
    
    // MARK: - Initializer
    init() {
        loadSampleData()
    }
    
    // MARK: - Task Management Methods
    
    /// Yeni görev ekleme
    func addTask() {
        guard !newTaskTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return
        }
        
        let newTask = Task(title: newTaskTitle.trimmingCharacters(in: .whitespacesAndNewlines))
        tasks.append(newTask)
        newTaskTitle = ""
        
        // Görevleri tarihe göre sırala (yeni eklenenler üstte)
        sortTasks()
    }
    
    /// Görev silme
    func deleteTask(at indexSet: IndexSet) {
        tasks.remove(atOffsets: indexSet)
    }
    
    /// Belirli bir görevi silme
    func deleteTask(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks.remove(at: index)
        }
    }
    
    /// Görev tamamlanma durumunu değiştirme
    func toggleTaskCompletion(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
            sortTasks()
        }
    }
    
    /// Görev başlığını düzenleme
    func updateTask(_ task: Task, newTitle: String) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].title = newTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
    
    /// Tüm tamamlanmış görevleri silme
    func clearCompletedTasks() {
        tasks.removeAll { $0.isCompleted }
    }
    
    /// Tüm görevleri silme
    func clearAllTasks() {
        tasks.removeAll()
    }
    
    // MARK: - Helper Methods
    
    /// Görevleri sıralama (tamamlanmayanlar üstte, tarih sırasına göre)
    private func sortTasks() {
        tasks.sort { first, second in
            if first.isCompleted != second.isCompleted {
                return !first.isCompleted // Tamamlanmayanlar önce
            }
            return first.createdAt > second.createdAt // Yeni eklenenler önce
        }
    }
    
    /// Örnek veri yükleme
    private func loadSampleData() {
        tasks = Task.sampleTasks
        sortTasks()
    }
}
