//
//  AddEventView.swift
//  Event
//
//  Created by Mehmet Emin Cetin on 12.09.2025.
//

import SwiftUI

struct AddEventView: View {
    @ObservedObject var viewModel: EventViewModel
    @Binding var isPresented: Bool
    
    @State private var title = ""
    @State private var date = Date()
    @State private var selectedType = EventType.other
    @State private var hasReminder = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Etkinlik Bilgileri")) {
                    TextField("Etkinlik adı", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    DatePicker("Tarih", selection: $date, displayedComponents: .date)
                    
                    Picker("Tür", selection: $selectedType) {
                        ForEach(EventType.allCases, id: \.self) { type in
                            HStack {
                                Text(type.emoji)
                                Text(type.displayName)
                            }
                            .tag(type)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    Toggle("Hatırlatıcı", isOn: $hasReminder)
                }
            }
            .navigationTitle("Yeni Etkinlik")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("İptal") {
                    isPresented = false
                },
                trailing: Button("Kaydet") {
                    saveEvent()
                }
                .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            )
        }
    }
    
    private func saveEvent() {
        let newEvent = Event(
            title: title.trimmingCharacters(in: .whitespacesAndNewlines),
            date: date,
            type: selectedType,
            hasReminder: hasReminder
        )
        
        viewModel.addEvent(newEvent)
        isPresented = false
    }
}
