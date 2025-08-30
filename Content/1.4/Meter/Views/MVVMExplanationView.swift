//
//  MVVMExplanationView.swift
//  Meter
//
//  Created by Mehmet Emin Çetin on 30.08.2025.
//

import SwiftUI

// MARK: - MVVM Explanation View
struct MVVMExplanationView: View {
    @State private var simpleCounter: Int = 0
    @StateObject private var viewModel = CounterViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 28) {
                
                // Header
                VStack(spacing: 12) {
                    Image(systemName: "cube.transparent")
                        .font(.system(size: 48))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.purple, .pink],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    
                    Text("MVVM Pattern")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundStyle(.primary)
                    
                    Text("Model-View-ViewModel")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding(.top, 20)
                .padding(.bottom, 20)
                
                // @State Example
                ExplanationCard(
                    title: "@State",
                    description: "View'in kendi içinde kullandığı basit veri",
                    color: .blue,
                    icon: "swift"
                ) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Değer: \(simpleCounter)")
                                .font(.headline)
                                .fontWeight(.semibold)
                            
                            Text("View'de yerel state")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                        
                        HStack(spacing: 12) {
                            Button(action: { simpleCounter += 1 }) {
                                Image(systemName: "plus")
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                    .frame(width: 36, height: 36)
                                    .background(.blue)
                                    .clipShape(Circle())
                            }
                            
                            Button(action: { simpleCounter -= 1 }) {
                                Image(systemName: "minus")
                                    .font(.headline)
                                    .foregroundStyle(.blue)
                                    .frame(width: 36, height: 36)
                                    .background(.blue.opacity(0.1))
                                    .clipShape(Circle())
                            }
                        }
                    }
                }
                
                // @StateObject Example
                ExplanationCard(
                    title: "@StateObject",
                    description: "ViewModel ile bağlantı kurar",
                    color: .green,
                    icon: "link"
                ) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Değer: \(viewModel.count)")
                                .font(.headline)
                                .fontWeight(.semibold)
                            
                            Text("ViewModel bağlantısı")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                        
                        HStack(spacing: 12) {
                            Button(action: viewModel.increment) {
                                Image(systemName: "plus")
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                    .frame(width: 36, height: 36)
                                    .background(.green)
                                    .clipShape(Circle())
                            }
                            
                            Button(action: viewModel.decrement) {
                                Image(systemName: "minus")
                                    .font(.headline)
                                    .foregroundStyle(.green)
                                    .frame(width: 36, height: 36)
                                    .background(.green.opacity(0.1))
                                    .clipShape(Circle())
                            }
                        }
                    }
                }
                
                // MVVM Architecture Section
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Image(systemName: "building.columns")
                            .font(.title2)
                            .foregroundStyle(.purple)
                        
                        Text("MVVM Katmanları")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    
                    VStack(spacing: 16) {
                        MVVMLayerView(
                            title: "Model",
                            description: "Veri yapıları ve business logic",
                            color: .orange,
                            example: "struct Counter",
                            icon: "server.rack"
                        )
                        
                        MVVMLayerView(
                            title: "ViewModel",
                            description: "Model ile View arası köprü",
                            color: .purple,
                            example: "class CounterViewModel",
                            icon: "arrow.left.arrow.right"
                        )
                        
                        MVVMLayerView(
                            title: "View",
                            description: "Kullanıcı arayüzü katmanı",
                            color: .pink,
                            example: "struct CounterView",
                            icon: "rectangle.on.rectangle"
                        )
                    }
                }
                
                // Benefits Section
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Image(systemName: "checkmark.seal")
                            .font(.title2)
                            .foregroundStyle(.green)
                        
                        Text("MVVM Avantajları")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 12) {
                        BenefitCard(title: "Temiz Kod", icon: "sparkles", color: .blue)
                        BenefitCard(title: "Test Edilebilir", icon: "checkmark.circle", color: .green)
                        BenefitCard(title: "Yeniden Kullanılabilir", icon: "arrow.triangle.2.circlepath", color: .orange)
                        BenefitCard(title: "Bakım Kolaylığı", icon: "wrench.and.screwdriver", color: .purple)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 30)
        }
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

// MARK: - Benefit Card Component
struct BenefitCard: View {
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(color)
            
            Text(title)
                .font(.caption)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
        }
        .frame(height: 80)
        .frame(maxWidth: .infinity)
        .background(color.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(color.opacity(0.3), lineWidth: 1)
        )
    }
}

#Preview {
    MVVMExplanationView()
}
