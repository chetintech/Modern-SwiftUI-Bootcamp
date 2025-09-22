//
//  CounterViewModel.swift
//  Meter
//
//  Created by Mehmet Emin Çetin on 30.08.2025.
//

import SwiftUI

// MARK: - ViewModel
class CounterViewModel: ObservableObject {
    @Published private var counter = Counter()
    
    // Computed properties - Model'den View'e veri aktarımı
    var count: Int { counter.value }
    var isPositive: Bool { counter.isPositive }
    var isNegative: Bool { counter.isNegative }
    var isZero: Bool { counter.isZero }
    
    var statusColor: Color {
        if isPositive { return .green }
        if isNegative { return .red }
        return .gray
    }
    
    var statusText: String {
        if isPositive { return "Pozitif" }
        if isNegative { return "Negatif" }
        return "Sıfır"
    }
    
    // Actions - View'den gelen komutları Model'e aktarır
    func increment() {
        counter.increment()
    }
    
    func decrement() {
        counter.decrement()
    }
    
    func reset() {
        counter.reset()
    }
}
