//
//  SwiftUIView.swift
//  DesignSystem
//
//  Created by Theo Sementa on 21/01/2026.
//

import SwiftUI
import Core

public struct NumericKeyboardView: View {
    
    // MARK: Dependencies
    @Binding private var value: String
    private var validationAction: () async -> Void
    
    // MARK: Environments
    @Environment(\.theme) private var theme
    
    // MARK: States
    @State private var isLoading: Bool = false
    
    // MARK: Init
    public init(
        value: Binding<String>,
        validationAction: @escaping () async -> Void,
    ) {
        self._value = value
        self.validationAction = validationAction
    }
    
    // MARK: - View
    public var body: some View {
        VStack(spacing: .medium) {
            HStack(spacing: .standard) {
                keyboardRow("1")
                keyboardRow("2")
                keyboardRow("3")
            }
            
            HStack(spacing: .standard) {
                keyboardRow("4")
                keyboardRow("5")
                keyboardRow("6")
            }
            
            HStack(spacing: .standard) {
                keyboardRow("7")
                keyboardRow("8")
                keyboardRow("9")
            }
            
            HStack(spacing: .standard) {
                keyboardRow(".")
                keyboardRow("0")
                validationButton
            }
            .fixedSize(horizontal: false, vertical: true)
        }
    }
}

// MARK: - Subviews
extension NumericKeyboardView {
    
    @ViewBuilder
    private func keyboardRow(_ character: String) -> some View {
        Button {
            if let dotIndex = value.firstIndex(of: ".") {
                if character != "." {
                    let decimalPart = value.suffix(from: value.index(after: dotIndex))
                    if decimalPart.count < 2 {
                        value.append(character)
                    }
                }
            } else {
                if value == "0" && character != "." {
                    value = ""
                }
                value.append(character)
            }
            VibrationManager.vibration()
        } label: {
            Text(character)
                .font(.Display.mediumBold, color: .Text.primary)
                .padding(.standard)
                .fullWidth()
                .background(Color.Background.bg100, in: .rect(cornerRadius: .standard, style: .continuous))
        }
    }
    
    @ViewBuilder
    private var validationButton: some View {
        Button {
            VibrationManager.vibration()
            Task {
                isLoading = true
                await validationAction()
                isLoading = false
            }
        } label: {
            Group {
                if isLoading {
                    ProgressView()
                        .foregroundStyle(Color.Base.white)
                        .frame(width: 24, height: 24)
                } else {
                    IconView(.iconCheckmarkRounded, color: .Base.white)
                }
            }
            .padding(.standard)
            .fullSize()
            .background(theme.color, in: .rect(cornerRadius: .standard, style: .continuous))
        }
        .disabled(isLoading)
    }
    
}

// MARK: - Preview
#Preview {
    @Previewable @State var value: String = ""
    NumericKeyboardView(value: $value, validationAction: { print(value) })
        .padding(.large)
        .background(Color.Background.bg50)
}
