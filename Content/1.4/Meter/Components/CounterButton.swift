//
//  CounterButton.swift
//  Meter
//
//  Created by Mehmet Emin Çetin on 30.08.2025.
//

import SwiftUI

// MARK: - Counter Button Component
struct CounterButton: View {
    let title: String
    let systemImage: String
    let color: Color
    let action: () -> Void
    
    @State private var isPressed = false
    
    var body: some View {
        Button(action: {
            // Haptic feedback
            let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
            impactFeedback.impactOccurred()
            
            action()
        }) {
            VStack(spacing: 12) {
                ZStack {
                    // Background circle with gradient
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [
                                    color.opacity(0.2),
                                    color.opacity(0.08)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 90, height: 90)
                        .overlay(
                            Circle()
                                .stroke(color.opacity(0.4), lineWidth: 3)
                        )
                        .shadow(color: color.opacity(0.25), radius: 15, x: 0, y: 8)
                    
                    // Icon
                    Image(systemName: systemImage)
                        .font(.system(size: 35, weight: .bold))
                        .foregroundStyle(color)
                }
                
                // Title
                Text(title)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundStyle(color)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .scaleEffect(isPressed ? 0.85 : 1.0)
        .animation(.easeInOut(duration: 0.15), value: isPressed)
        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
            isPressed = pressing
        }, perform: {})
    }
}

#Preview {
    HStack(spacing: 40) {
        CounterButton(
            title: "Azalt",
            systemImage: "minus",
            color: .red,
            action: {}
        )
        
        CounterButton(
            title: "Artır",
            systemImage: "plus",
            color: .green,
            action: {}
        )
    }
    .padding()
}
