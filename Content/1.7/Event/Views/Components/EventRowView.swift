//
//  EventRowView.swift
//  Event
//
//  Created by Mehmet Emin Cetin on 12.09.2025.
//

import SwiftUI

struct EventRowView: View {
    let event: Event
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(event.type.emoji)
                        .font(.title2)
                    Text(event.title)
                        .font(.headline)
                        .foregroundColor(.primary)
                }
                
                Text(event.date, style: .date)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(event.type.displayName)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .background(Color.blue.opacity(0.1))
                    .foregroundColor(.blue)
                    .cornerRadius(4)
            }
            
            Spacer()
            
            if event.hasReminder {
                Image(systemName: "bell.fill")
                    .foregroundColor(.orange)
                    .font(.caption)
            }
        }
        .padding(.vertical, 4)
    }
}

