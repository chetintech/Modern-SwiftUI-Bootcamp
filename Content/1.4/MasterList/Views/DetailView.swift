//
//  DetailView.swift
//  MasterListApp
//
//  Created by Mehmet Emin Cetin on 8.09.2025.
//

import SwiftUI

struct DetailView: View {
    let item: ListItem
    @ObservedObject var viewModel: ListViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Header
                VStack(spacing: 20) {
                    Image(systemName: item.sfSymbol)
                        .font(.system(size: 80))
                        .foregroundColor(viewModel.themeColor)
                        .padding()
                        .background(
                            Circle()
                                .fill(viewModel.themeColor.opacity(0.1))
                                .frame(width: 150, height: 150)
                        )
                    
                    Text(item.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .strikethrough(item.isCompleted)
                }
                
                // Description Card
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Image(systemName: "text.alignleft")
                            .foregroundColor(viewModel.themeColor)
                        Text("Açıklama")
                            .font(.headline)
                    }
                    
                    Text(item.description)
                        .font(.body)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                
                // Status Card
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Image(systemName: "info.circle")
                            .foregroundColor(viewModel.themeColor)
                        Text("Durum")
                            .font(.headline)
                    }
                    
                    HStack {
                        Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(item.isCompleted ? .green : .gray)
                        Text(item.isCompleted ? "Tamamlandı" : "Bekliyor")
                            .font(.subheadline)
                        Spacer()
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
                .padding(.horizontal)
                
                // Action Button
                Button(action: {
                    withAnimation(.spring()) {
                        viewModel.toggleCompletion(for: item)
                    }
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: item.isCompleted ? "arrow.counterclockwise" : "checkmark")
                        Text(item.isCompleted ? "Tekrar Aç" : "Tamamla")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(viewModel.themeColor)
                    .cornerRadius(12)
                }
                .padding(.horizontal)
                
                Spacer(minLength: 50)
            }
            .padding()
        }
        .navigationTitle("Detay")
        .navigationBarTitleDisplayMode(.inline)
    }
}
