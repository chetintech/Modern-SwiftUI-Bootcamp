//
//  ListViewModel.swift
//  MasterListApp
//
//  Created by Mehmet Emin Cetin on 8.09.2025.
//


import SwiftUI

class ListViewModel: ObservableObject {
    @Published var items: [ListItem] = []
    @Published var themeColor: Color = .blue
    @Published var showingAddSheet = false
    @Published var newItemTitle = ""
    @Published var newItemDescription = ""
    
    init() {
        loadInitialData()
        setRandomTheme()
    }
    
    private func loadInitialData() {
        items = [
            ListItem(title: "Swift Öğren", description: "SwiftUI temellerini öğren ve pratik yap"),
            ListItem(title: "Spor Yap", description: "Haftalık 3 gün spor yapma hedefi"),
            ListItem(title: "Kitap Oku", description: "Ayda en az 2 kitap okuma hedefi"),
            ListItem(title: "Proje Tamamla", description: "iOS uygulama projeni bitir"),
            ListItem(title: "Dil Öğren", description: "Günlük 30 dakika İngilizce çalış", isCompleted: true),
            ListItem(title: "Alışveriş", description: "Haftalık market alışverişini yap", isCompleted: true),
            ListItem(title: "Temizlik", description: "Ev temizliği ve düzenlemesi", isCompleted: true),
            ListItem(title: "Arkadaş Ziyareti", description: "Uzun zamandır görüşemediğin arkadaşını ziyaret et"),
            ListItem(title: "Film İzle", description: "İzleme listendeki filmleri izle"),
            ListItem(title: "Müzik Dinle", description: "Yeni çıkan albümleri keşfet")
        ]
    }
    
    private func setRandomTheme() {
        let colors: [Color] = [.blue, .green, .purple, .orange, .red, .pink, .cyan, .mint]
        themeColor = colors.randomElement() ?? .blue
    }
    
    func addItem() {
        guard !newItemTitle.isEmpty else { return }
        let newItem = ListItem(title: newItemTitle, description: newItemDescription)
        items.append(newItem)
        newItemTitle = ""
        newItemDescription = ""
        showingAddSheet = false
    }
    
    func deleteItem(at indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func toggleCompletion(for item: ListItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].isCompleted.toggle()
        }
    }
    
    var pendingItems: [ListItem] {
        items.filter { !$0.isCompleted }
    }
    
    var completedItems: [ListItem] {
        items.filter { $0.isCompleted }
    }
}
