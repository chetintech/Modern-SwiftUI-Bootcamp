//
//  AlternativeListViewRow.swift
//  MasterListApp
//
//  Created by Mehmet Emin Cetin on 8.09.2025.
//

import SwiftUI

struct AlternativeRowView: View {
    let item: ListItem
    let themeColor: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: item.sfSymbol)
                .font(.title2)
                .foregroundColor(themeColor)
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.headline)
                    .strikethrough(item.isCompleted)
                    .foregroundColor(.primary)
                
                Text(item.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            
            Spacer()
            
            if item.isCompleted {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                    .font(.title2)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

