//
//  EventDetailView.swift
//  Event
//
//  Created by Mehmet Emin Cetin on 12.09.2025.
//

import SwiftUI

struct EventDetailView: View {
    let event: Event
    @ObservedObject var viewModel: EventViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header
                VStack(alignment: .center, spacing: 16) {
                    Text(event.type.emoji)
                        .font(.system(size: 60))
                    
                    Text(event.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 20)
                
                // Details
                VStack(spacing: 16) {
                    DetailRowView(
                        icon: "calendar",
                        title: "Tarih",
                        value: DateFormatter.eventDate.string(from: event.date)
                    )
                    
                    DetailRowView(
                        icon: "tag",
                        title: "Tür",
                        value: event.type.displayName
                    )
                    
                    DetailRowView(
                        icon: event.hasReminder ? "bell.fill" : "bell.slash",
                        title: "Hatırlatıcı",
                        value: event.hasReminder ? "Açık" : "Kapalı"
                    )
                    
                    if event.hasReminder {
                        DetailRowView(
                            icon: "clock",
                            title: "Kalan Süre",
                            value: timeUntilEvent()
                        )
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                // Delete Button
                Button(action: {
                    showingDeleteAlert = true
                }) {
                    Label("Etkinliği Sil", systemImage: "trash")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
        }
        .navigationTitle("Etkinlik Detayı")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Etkinliği Sil", isPresented: $showingDeleteAlert) {
            Button("İptal", role: .cancel) { }
            Button("Sil", role: .destructive) {
                viewModel.deleteEvent(event)
                presentationMode.wrappedValue.dismiss()
            }
        } message: {
            Text("Bu etkinliği silmek istediğinizden emin misiniz? Bu işlem geri alınamaz.")
        }
    }
    
    private func timeUntilEvent() -> String {
        let calendar = Calendar.current
        let now = Date()
        
        if calendar.isDate(event.date, inSameDayAs: now) {
            return "Bugün"
        }
        
        let components = calendar.dateComponents([.day], from: now, to: event.date)
        let days = components.day ?? 0
        
        if days < 0 {
            return "\(abs(days)) gün geçti"
        } else if days == 0 {
            return "Bugün"
        } else if days == 1 {
            return "Yarın"
        } else {
            return "\(days) gün kaldı"
        }
    }
}
