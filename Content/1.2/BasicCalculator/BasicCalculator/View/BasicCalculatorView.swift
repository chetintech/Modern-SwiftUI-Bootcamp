//
//  ContentView.swift
//  BasicCalculator
//
//  Created by Mehmet Emin Çetin on 17.08.2025.
//

import SwiftUI

struct BasicCalculatorView: View {
    @StateObject private var viewModel = CalculatorViewModel()
    
    private let buttons: [[CalculatorButton]] = [
        [.clear, .operation(.divide), .operation(.multiply), .operation(.subtract)],
        [.number(7), .number(8), .number(9), .operation(.add)],
        [.number(4), .number(5), .number(6), .equals],
        [.number(1), .number(2), .number(3), .number(0)]
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Hesap Makinesi")
                .font(.title)
                .bold()
            
            // Display
            Text(viewModel.displayText)
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            
            // Buttons Grid
            VStack(spacing: 10) {
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 10) {
                        ForEach(row, id: \.self) { button in
                            CalculatorButtonView(button: button) {
                                handleButtonPress(button)
                            }
                        }
                    }
                }
            }
            
            Spacer()
        }
        .padding()
    }
    
    private func handleButtonPress(_ button: CalculatorButton) {
        switch button {
        case .number(let num): viewModel.numberPressed(num)
        case .operation(let op): viewModel.operationPressed(op)
        case .equals: viewModel.equalsPressed()
        case .clear: viewModel.clearPressed()
        }
    }
}

// MARK: - Calculator Button View
struct CalculatorButtonView: View {
    let button: CalculatorButton
    let action: () -> Void
    private let size: CGFloat = 70
    
    var body: some View {
        Button(action: action) {
            Text(button.title)
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: size, height: size)
                .background(button.color)
                .cornerRadius(size / 2)
        }
        .buttonStyle(PlainButtonStyle())
        .scaleEffect(button.isPressed ? 0.9 : 1.0)
    }
}

// MARK: - Button Model
enum CalculatorButton: Hashable {
    case number(Int)
    case operation(BasicCalculatorModel.Operation)
    case equals
    case clear
    
    var title: String {
        switch self {
        case .number(let n): return "\(n)"
        case .operation(let op): return op.rawValue
        case .equals: return "="
        case .clear: return "C"
        }
    }
    
    var color: Color {
        switch self {
        case .number: return .blue
        case .operation: return .orange
        case .equals: return .green
        case .clear: return .red
        }
    }
    
    // Optional: Daha ileri seviye animasyon için
    var isPressed: Bool { false }
}

#Preview {
    BasicCalculatorView()
}
