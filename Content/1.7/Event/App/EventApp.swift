//
//  EventApp.swift
//  Event
//
//  Created by Mehmet Emin Cetin on 12.09.2025.
//

import SwiftUI

@main
struct EventApp: App {
    var body: some Scene {
        WindowGroup {
            EventListView()
        }
    }
}

#Preview {
    EventListView()
}
