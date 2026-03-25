//
//  SwiftUIView.swift
//  Features
//
//  Created by Theo Sementa on 25/03/2026.
//

import SwiftUI
import DesignSystem
import Core
import MCEmojiPicker

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
            
            VStack(spacing: .standard) {
                emojiPickerView
                
                TextFieldView(
                    text: $viewModel.name,
                    title: "Nom de l'objectif", // TODO: TBL
                    placeholder: viewModel.namePlaceholder
                )
            }
            
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
        .padding(.standard)
        .background(Color.Background.bg50)
        .alertLeaveForm(isPresented: $viewModel.isAlertLeavePresented)
        .animation(.smooth, value: keyboardManager.isKeyboardVisible)
        .lockView()
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
    
    var emojiPickerView: some View {
        Button { viewModel.showEmojiPicker.toggle() } label: {
            Text(viewModel.emoji)
                .font(.Title.mediumMedium)
                .frame(width: 20, height: 20)
                .padding(.medium)
                .background(Color.Background.bg100, in: .rect(cornerRadius: .standard, style: .continuous))
        }
        .emojiPicker(
            isPresented: $viewModel.showEmojiPicker,
            selectedEmoji: $viewModel.emoji
        )
    }
}

// MARK: - Preview
#Preview {
    AddFinancialGoalScreen()
}
