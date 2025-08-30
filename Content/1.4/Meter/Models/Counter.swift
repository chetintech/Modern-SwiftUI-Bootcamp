//
//  Counter.swift
//  Meter
//
//  Created by Mehmet Emin Çetin on 30.08.2025.
//

import Foundation

// MARK: - Model
struct Counter {
    var value: Int = 0
    
    // Computed properties
    var isPositive: Bool { value > 0 }
    var isNegative: Bool { value < 0 }
    var isZero: Bool { value == 0 }
    
    // Actions
    mutating func increment() {
        value += 1
    }
    
    mutating func decrement() {
        value -= 1
    }
    
    mutating func reset() {
        value = 0
    }
}
