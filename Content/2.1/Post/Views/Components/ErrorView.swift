//
//  ErrorView.swift
//  Post
//
//  Created by Mehmet Emin Cetin on 22.09.2025.
//

import SwiftUI

struct ErrorView: View {
    let message: String
    let retryAction: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .symbolRenderingMode(.palette)
                .foregroundStyle(.red, .yellow)
                .font(.system(size: 64))
            
            HStack(spacing: 8) {
                Image(systemName: "exclamationmark.bubble")
                    .foregroundColor(.red)
                Text("An error occurred")
                    .font(.headline)
            }
            
            Text(message)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            
            Button("Try Again") {
                retryAction()
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)
        }
        .padding()
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: .red.opacity(0.08), radius: 10)
        .frame(maxWidth: 420)
    }
}
