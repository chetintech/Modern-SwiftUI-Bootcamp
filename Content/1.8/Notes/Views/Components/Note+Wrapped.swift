//
//  Note+Wrapped.swift
//  Notes
//
//  Created by Mehmet Emin Cetin on 22.09.2025.
//

import Foundation

extension Note {
    /// A non-optional identifier for use with SwiftUI lists.
    /// Falls back to a transient UUID if `id` is nil. Your app assigns `id` when creating notes.
    public var wrappedID: UUID {
        id ?? UUID()
    }

    /// A non-optional title with a sensible default.
    public var wrappedTitle: String {
        let trimmed = (title ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? "Untitled" : trimmed
    }

    /// A non-optional content string.
    public var wrappedContent: String {
        content ?? ""
    }

    /// A non-optional date with a default of now if missing.
    public var wrappedDate: Date {
        date ?? Date()
    }
}
