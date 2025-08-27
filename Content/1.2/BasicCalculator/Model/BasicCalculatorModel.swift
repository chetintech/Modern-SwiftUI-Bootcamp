//
//  Model.swift
//  BasicCalculator
//
//  Created by Mehmet Emin Çetin on 17.08.2025.
//

import Foundation

struct BasicCalculatorModel {
    var currentValue: Double = 0
    var previousValue: Double = 0
    var operation: Operation? = nil
    var waitingForNewValue: Bool = true
    
    enum Operation: String {
        case add = "+"
        case subtract = "-"
        case multiply = "×"
        case divide = "÷"
        
        func calculate(_ first: Double, _ second: Double) -> Double {
            switch self {
            case .add: return first + second
            case .subtract: return first - second
            case .multiply: return first * second
            case .divide: return second != 0 ? first / second : 0
            }
        }
    }
}

