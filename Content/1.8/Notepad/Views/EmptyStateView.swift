//
//  EmptyStateView.swift
//  Notepad
//
//  Created by Mehmet Emin Cetin on 12.09.2025.
//

import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "note.text")
                .font(.system(size: 60))
                .foregroundColor(.secondary)
            
            Text("Henüz not yok")
                .font(.title2)
                .fontWeight(.medium)
            
            Text("Sağ üstteki + butonuna tıklayarak ilk notunuzu ekleyin")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
