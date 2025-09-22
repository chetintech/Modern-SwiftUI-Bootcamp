//
//  ContentView.swift
//  Task
//
//  Created by Mehmet Emin Cetin on 11.09.2025.
//

import SwiftUI

// MARK: - Main Content View
struct ContentView: View {
    @StateObject private var viewModel = TaskViewModel()
    @State private var showingAddTask = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Üst İstatistik Bölümü
                TaskStatisticsView(viewModel: viewModel)
                
                // Görev Listesi
                TaskListView(viewModel: viewModel)
                
                // Alt Butonlar
                TaskActionButtonsView(viewModel: viewModel, showingAddTask: $showingAddTask)
            }
            .navigationTitle("Görevlerim")
            .sheet(isPresented: $showingAddTask) {
                AddTaskView(viewModel: viewModel, isPresented: $showingAddTask)
            }
        }
    }
}

// MARK: - Task Statistics View
struct TaskStatisticsView: View {
    @ObservedObject var viewModel: TaskViewModel
    
    var body: some View {
        HStack {
            StatisticCard(
                title: "Aktif",
                count: viewModel.activeTaskCount,
                color: .blue
            )
            
            StatisticCard(
                title: "Tamamlanan",
                count: viewModel.completedTaskCount,
                color: .green
            )
            
            StatisticCard(
                title: "Toplam",
                count: viewModel.tasks.count,
                color: .purple
            )
        }
        .padding()
    }
}

// MARK: - Statistic Card
struct StatisticCard: View {
    let title: String
    let count: Int
    let color: Color
    
    var body: some View {
        VStack {
            Text("\(count)")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(color)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(color.opacity(0.1))
        )
    }
}

// MARK: - Task List View
struct TaskListView: View {
    @ObservedObject var viewModel: TaskViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.tasks) { task in
                TaskRowView(task: task, viewModel: viewModel)
            }
            .onDelete(perform: viewModel.deleteTask)
        }
        .listStyle(PlainListStyle())
    }
}

// MARK: - Task Row View
struct TaskRowView: View {
    let task: Task
    @ObservedObject var viewModel: TaskViewModel
    @State private var isEditing = false
    @State private var editedTitle = ""
    
    var body: some View {
        HStack {
            // Tamamlanma Butonu
            Button(action: {
                withAnimation(.spring(response: 0.3)) {
                    viewModel.toggleTaskCompletion(task)
                }
            }) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(task.isCompleted ? .green : .gray)
                    .font(.title2)
            }
            
            // Görev Başlığı
            if isEditing {
                TextField("Görev başlığı", text: $editedTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onSubmit {
                        viewModel.updateTask(task, newTitle: editedTitle)
                        isEditing = false
                    }
            } else {
                VStack(alignment: .leading, spacing: 2) {
                    Text(task.title)
                        .strikethrough(task.isCompleted)
                        .foregroundColor(task.isCompleted ? .secondary : .primary)
                        .font(.body)
                    
                    Text(formatDate(task.createdAt))
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            // Düzenleme Butonu
            if !isEditing {
                Button("Tamamlandı") {
                    editedTitle = task.title
                    isEditing = true
                }
                .font(.caption)
                .foregroundColor(.blue)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            if !isEditing {
                withAnimation(.spring(response: 0.3)) {
                    viewModel.toggleTaskCompletion(task)
                }
            }
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

// MARK: - Task Action Buttons View
struct TaskActionButtonsView: View {
    @ObservedObject var viewModel: TaskViewModel
    @Binding var showingAddTask: Bool
    
    var body: some View {
        VStack(spacing: 12) {
            // Görev Ekleme Bölümü
            HStack {
                TextField("Yeni görev ekle...", text: $viewModel.newTaskTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Ekle") {
                    viewModel.addTask()
                }
                .buttonStyle(.borderedProminent)
                .disabled(viewModel.newTaskTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
            
            // Alt Butonlar
            HStack {
                Button("Tamamlananları Sil") {
                    withAnimation {
                        viewModel.clearCompletedTasks()
                    }
                }
                .buttonStyle(.bordered)
                .disabled(viewModel.completedTaskCount == 0)
                
                Spacer()
                
                Button("Tümünü Sil") {
                    withAnimation {
                        viewModel.clearAllTasks()
                    }
                }
                .buttonStyle(.bordered)
                .foregroundColor(.red)
                .disabled(viewModel.tasks.isEmpty)
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
    }
}

// MARK: - Add Task View (Modal)
struct AddTaskView: View {
    @ObservedObject var viewModel: TaskViewModel
    @Binding var isPresented: Bool
    @State private var taskTitle = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Görev başlığı", text: $taskTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Spacer()
            }
            .navigationTitle("Yeni Görev")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("İptal") {
                    isPresented = false
                },
                trailing: Button("Kaydet") {
                    viewModel.newTaskTitle = taskTitle
                    viewModel.addTask()
                    isPresented = false
                }
                .disabled(taskTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            )
        }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
