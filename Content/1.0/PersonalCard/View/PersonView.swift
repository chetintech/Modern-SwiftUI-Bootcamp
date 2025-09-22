//
//  ContentView.swift
//  PersonalCard
//
//  Created by Mehmet Emin Çetin on 17.08.2025.
//

import SwiftUI

struct PersonView: View {
    @StateObject private var viewModel = PersonViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            // Avatar
            Image("profilePhoto")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
                .foregroundColor(.blue)
                .cornerRadius(20)
                .padding(.top, 40)
                
            // Name and Job
            Text(viewModel.person.name ?? "No Name")
                .font(.title)
                .fontWeight(.bold)
            
            Text(viewModel.person.jobTitle ?? "No Job")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Divider()
                .padding(.vertical, 20)
            
            // Contact Info
            HStack {
                Image(systemName: "envelope.fill")
                    .foregroundColor(.blue)
                Text(viewModel.person.email ?? "No Email")
            }
            
            HStack {
                Image(systemName: "phone.fill")
                    .foregroundColor(.blue)
                Text(viewModel.person.phone ?? "No Phone")
            }
            
            Divider()
            
            // Extra Info
            VStack(spacing: 5) {
                Text("Age: \(viewModel.person.age ?? 0)")
                Text("Salary: $\(viewModel.person.salary ?? 0.0, specifier: "%.2f")")
                Text("Employed: \(viewModel.person.isEmployed == true ? "Yes" : "No")")
            }
            .font(.body)
            .foregroundColor(.gray)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    PersonView()
}
