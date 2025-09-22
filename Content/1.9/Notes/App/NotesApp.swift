//
//  NotesApp.swift
//  Notes
//
//  Created by Mehmet Emin Cetin on 22.09.2025.
//

import SwiftUI
import CoreData

@main
struct NotesApp: App {
    let persistenceController = CoreDataManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

