//
//  CounterView.swift
//  Meter
//
//  Created by Mehmet Emin Çetin on 30.08.2025.
//

import SwiftUI

// MARK: - Main Counter View
struct CounterView: View {
    @StateObject private var viewModel = CounterViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            // Header Section
            VStack(spacing: 16) {
                Text("Sayaç Uygulaması")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                
                Text("MVVM Pattern ile SwiftUI")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding(.top, 20)
            
            Spacer()
            
            // Counter Display Section - Centered
            VStack(spacing: 40) {
                // Main Counter Value
                ZStack {
                    // Background Circle
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [
                                    viewModel.statusColor.opacity(0.15),
                                    viewModel.statusColor.opacity(0.05)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 250, height: 250)
                        .overlay(
                            Circle()
                                .stroke(viewModel.statusColor.opacity(0.4), lineWidth: 4)
                        )
                        .shadow(color: viewModel.statusColor.opacity(0.3), radius: 20, x: 0, y: 10)
                    
                    // Counter Value
                    Text("\(viewModel.count)")
                        .font(.system(size: 80, weight: .bold, design: .rounded))
                        .foregroundStyle(viewModel.statusColor)
                        .contentTransition(.numericText())
                        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: viewModel.count)
                }
                
                // Status Indicator
                HStack(spacing: 12) {
                    Image(systemName: viewModel.isPositive ? "arrow.up.circle.fill" :
                          viewModel.isZero ? "circle.fill" : "arrow.down.circle.fill")
                        .font(.title2)
                        .foregroundStyle(viewModel.statusColor)
                    
                    Text(viewModel.statusText)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(viewModel.statusColor)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(
                    Capsule()
                        .fill(viewModel.statusColor.opacity(0.12))
                        .stroke(viewModel.statusColor.opacity(0.3), lineWidth: 1.5)
                )
                .animation(.easeInOut(duration: 0.3), value: viewModel.count)
            }
            
            Spacer()
            
            // Controls Section - Bottom
            VStack(spacing: 30) {
                // Increment/Decrement Buttons
                HStack(spacing: 60) {
                    CounterButton(
                        title: "Azalt",
                        systemImage: "minus",
                        color: .red,
                        action: viewModel.decrement
                    )
                    
                    CounterButton(
                        title: "Artır",
                        systemImage: "plus",
                        color: .green,
                        action: viewModel.increment
                    )
                }
                
                // Reset Button
                Button(action: viewModel.reset) {
                    HStack(spacing: 12) {
                        Image(systemName: "arrow.clockwise")
                            .font(.headline)
                        Text("Sıfırla")
                            .font(.headline)
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(.white)
                    .frame(width: 200, height: 50)
                    .background(
                        LinearGradient(
                            colors: viewModel.isZero ? [.gray.opacity(0.6)] : [.blue, .indigo],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .clipShape(Capsule())
                    .shadow(color: viewModel.isZero ? .clear : .blue.opacity(0.3), radius: 10, x: 0, y: 5)
                }
                .disabled(viewModel.isZero)
                .scaleEffect(viewModel.isZero ? 0.95 : 1.0)
                .animation(.easeInOut(duration: 0.2), value: viewModel.isZero)
            }
            .padding(.bottom, 50)
        }
        .padding(.horizontal, 30)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(
                colors: [
                    Color(.systemBackground),
                    Color(.systemGray6).opacity(0.3)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
    }
}

#Preview {
    CounterView()
}
