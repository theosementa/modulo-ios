//
//  SwiftUIView.swift
//  Features
//
//  Created by Theo Sementa on 25/03/2026.
//

import SwiftUI
import DesignSystem
import Core

struct AddFinancialGoalScreen: View {
    
    // MARK: Environments
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @Environment(\.dismiss) private var dismiss
    
    // MARK: States
    @State private var viewModel: ViewModel = .init()
    @StateObject private var keyboardManager: KeyboardManager = .init()
    
    // MARK: - View
    var body: some View {
        VStack(spacing: .standard) {
            DismissButtonView { viewModel.dismissAction() }
                .fullWidth(.trailing)
            
            amountView
                .fullSize()
            
            VStack(spacing: .medium) {
                HStack(spacing: .medium) {
                    DatePickerView(date: $viewModel.startDate)
                    DatePickerView(date: $viewModel.endDate, placeholder: "Date de fin") // TODO: TBL
                }
                
                if keyboardManager.isKeyboardVisible {
                    Color.clear.frame(height: keyboardManager.keyboardHeight - safeAreaInsets.bottom - .standard)
                } else {
                    NumericKeyboardView(
                        value: $viewModel.amount,
                        validationAction: { await viewModel.validationAction() }
                    )
                }
            }
        }
        .lockView()
        .padding(.standard)
        .background(Color.Background.bg50)
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: - Subviews
extension AddFinancialGoalScreen {
    
    var amountView: some View {
        HStack(spacing: .tiny) {
            Text(UserCurrency.symbol)
                .font(.Display.smallSemiBold, color: .Text.tertiary)
            Text(viewModel.amount)
                .contentTransition(.numericText())
                .font(.Display.extraLargeSemiBold)
        }
        .animation(.smooth, value: viewModel.amount)
        .fullWidth()
        .overlay(alignment: .trailing) {
            DeleteNumberButtonView(amount: $viewModel.amount)
                .isDisplayed(viewModel.amount != "0")
        }
    }
    
}

// MARK: - Preview
#Preview {
    AddFinancialGoalScreen()
}
