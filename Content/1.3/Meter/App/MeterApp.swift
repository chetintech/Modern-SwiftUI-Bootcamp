//
//  MeterApp.swift
//  Meter
//
//  Created by Mehmet Emin Çetin on 30.08.2025.
//

import SwiftUI

@main
struct MeterApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                CounterView()
                    .tabItem {
                        Image(systemName: "number.circle.fill")
                        Text("Sayaç")
                    }
                
                MVVMExplanationView()
                    .tabItem {
                        Image(systemName: "cube.transparent.fill")
                        Text("MVVM")
                    }
            }
            .tint(.blue) // Tab bar tint color
        }
    }
}
