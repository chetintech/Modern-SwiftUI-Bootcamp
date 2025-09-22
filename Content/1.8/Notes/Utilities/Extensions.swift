//
//  Extensions.swift
//  Notes
//
//  Created by Mehmet Emin Cetin on 22.09.2025.
//

import Foundation
import SwiftUI
import CoreData

// MARK: - Preview Providers
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, CoreDataManager.shared.container.viewContext)
    }
}

struct NotesListView_Previews: PreviewProvider {
    static var previews: some View {
        NotesListView()
            .environment(\.managedObjectContext, CoreDataManager.shared.container.viewContext)
    }
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteView()
    }
}
