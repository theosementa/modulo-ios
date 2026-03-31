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
import ToastBannerKit

struct AddFinancialGoalScreen: View {
    
    // MARK: Environments
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @Environment(\.dismiss) private var dismiss
    @Environment(\.theme) private var theme
    
    // MARK: States
    @State private var viewModel: ViewModel
    @StateObject private var keyboardManager: KeyboardManager = .init()
    
    // MARK: Init
    init(goalId: String? = nil) {
        _viewModel = State(wrappedValue: .init(goalId: goalId))
    }
    
    // MARK: - View
    var body: some View {
        VStack(spacing: .standard) {
            DismissButtonView { viewModel.dismissAction() }
                .fullWidth(.trailing)
            
            VStack(spacing: .standard) {
                emojiPickerView
                
                TextFieldView(
                    text: $viewModel.name,
                    title: "add_goal_field_name_title".localized,
                    placeholder: viewModel.namePlaceholder.localized
                )
            }
            
            amountView
                .fullSize()
            
            VStack(spacing: .medium) {
                HStack(spacing: .medium) {
                    DatePickerView(date: $viewModel.startDate)
                    DatePickerView(date: $viewModel.endDate, placeholder: "generic_end_date".localized)
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
        .confirmationAlert(.leaveWithoutSaving, isPresented: $viewModel.isAlertLeavePresented) { dismiss() }
        .animation(.smooth, value: keyboardManager.isKeyboardVisible)
        .lockView()
        .navigationBarBackButtonHidden(true)
        .toastBanner(
            item: $viewModel.toastBannerService.toastBanner,
            config: .init(yOffset: 10, animation: .smooth),
        ) { toastBanner in
            ToastBannerView(banner: toastBanner)
        }
    }
}

// MARK: - Subviews
extension AddFinancialGoalScreen {
    
    var amountView: some View {
        HStack(spacing: .tiny) {
            Text(UserCurrency.symbol)
                .font(.Display.smallSemiBold, color: viewModel.amount != "0" ? theme.color : .Text.tertiary)
            Text(viewModel.amount)
                .font(.Display.extraLargeSemiBold)
                .contentTransition(.numericText())
        }
        .animation(.smooth, value: viewModel.amount)
        .onTapGesture { UIDevice.hideKeyboard() }
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
