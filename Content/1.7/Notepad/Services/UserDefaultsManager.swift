//
//  UserDefaultsManager.swift
//  Notepad
//
//  Created by Mehmet Emin Cetin on 12.09.2025.
//

import Foundation

protocol UserDefaultsManagerProtocol {
    func saveNotes(_ notes: [Note])
    func loadNotes() -> [Note]
}

class UserDefaultsManager: UserDefaultsManagerProtocol {
    private let userDefaults = UserDefaults.standard
    private let notesKey = "SavedNotes"
    
    func saveNotes(_ notes: [Note]) {
        do {
            let data = try JSONEncoder().encode(notes)
            userDefaults.set(data, forKey: notesKey)
        } catch {
            print("Not kaydetme hatası: \(error)")
        }
    }
    
    func loadNotes() -> [Note] {
        guard let data = userDefaults.data(forKey: notesKey) else {
            return []
        }
        
        do {
            return try JSONDecoder().decode([Note].self, from: data)
        } catch {
            print("Not yükleme hatası: \(error)")
            return []
        }
    }
}


