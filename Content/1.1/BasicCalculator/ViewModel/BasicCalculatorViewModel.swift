//
//  BasicCalculatorViewModel.swift
//  BasicCalculator
//
//  Created by Mehmet Emin Çetin on 17.08.2025.
//

import Foundation

class CalculatorViewModel: ObservableObject {
    @Published private var model = BasicCalculatorModel()
    @Published var displayText: String = "0"
    
    // MARK: - Public Methods
    func numberPressed(_ number: Int) {
        if model.waitingForNewValue {
            displayText = "\(number)"
            model.waitingForNewValue = false
        } else {
            displayText = displayText == "0" ? "\(number)" : displayText + "\(number)"
        }
        model.currentValue = Double(displayText) ?? 0
    }
    
    func operationPressed(_ operation: BasicCalculatorModel.Operation) {
        if model.operation != nil && !model.waitingForNewValue {
            calculateResult()
        }
        
        model.previousValue = model.currentValue
        model.operation = operation
        model.waitingForNewValue = true
    }
    
    func equalsPressed() {
        calculateResult()
    }
    
    func clearPressed() {
        model = BasicCalculatorModel()
        displayText = "0"
    }
    
    // MARK: - Private Methods
    private func calculateResult() {
        guard let operation = model.operation else { return }
            
        let result = operation.calculate(
            model.previousValue,
            model.currentValue
        )
        model.currentValue = result
        displayText = formatNumber(result)
        model.operation = nil
        model.waitingForNewValue = true
    }
        
    private func formatNumber(_ number: Double) -> String {
        if number.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", number)
        } else {
            return String(format: "%.2f", number)
        }
    }
}
