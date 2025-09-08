//
//  AddItemSheet.swift
//  MasterListApp
//
//  Created by Mehmet Emin Cetin on 8.09.2025.
//

import SwiftUI

struct AddItemSheet: View {
    @ObservedObject var viewModel: ListViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Yeni Öğe")) {
                    TextField("Başlık", text: $viewModel.newItemTitle)
                    TextField("Açıklama", text: $viewModel.newItemDescription, axis: .vertical)
                        .lineLimit(3...6)
                }
            }
            .navigationTitle("Yeni Öğe Ekle")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("İptal") {
                        viewModel.newItemTitle = ""
                        viewModel.newItemDescription = ""
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Ekle") {
                        viewModel.addItem()
                    }
                    .disabled(viewModel.newItemTitle.isEmpty)
                }
            }
        }
    }
}
