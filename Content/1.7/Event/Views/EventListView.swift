//
//  EventListView.swift
//  Event
//
//  Created by Mehmet Emin Cetin on 12.09.2025.
//

import SwiftUI

struct EventListView: View {
    @StateObject private var viewModel = EventViewModel()
    @State private var showingAddEvent = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.events) { event in
                    NavigationLink(destination: EventDetailView(event: event, viewModel: viewModel)) {
                        EventRowView(event: event)
                    }
                }
                .onDelete(perform: viewModel.deleteEvent)
            }
            .navigationTitle("Etkinlikler")
            .navigationBarItems(trailing: addButton)
            .sheet(isPresented: $showingAddEvent) {
                AddEventView(viewModel: viewModel, isPresented: $showingAddEvent)
            }
        }
    }
    
    private var addButton: some View {
        Button(action: {
            showingAddEvent = true
        }) {
            Image(systemName: "plus")
                .font(.title2)
        }
    }
}
