//
//  AddContributionScreen.swift
//  Features
//
//  Created by Theo Sementa on 26/03/2026.
//

import SwiftUI
import DesignSystem
import Core
import Models
import ToastBannerKit

struct AddContributionScreen: View {

    // MARK: Environments
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @Environment(\.dismiss) private var dismiss
    @Environment(\.theme) private var theme

    // MARK: States
    @State private var viewModel: ViewModel
    @StateObject private var keyboardManager: KeyboardManager = .init()

    // MARK: Init
    init(goalId: String, contributionId: String? = nil) {
        self._viewModel = State(wrappedValue: ViewModel(goalId: goalId, contributionId: contributionId))
    }

    // MARK: - View
    var body: some View {
        VStack(spacing: .standard) {
            DismissButtonView { viewModel.dismissAction() }
                .fullWidth(.trailing)

            TextFieldView(
                text: $viewModel.name,
                title: "add_contribution_field_name_title".localized,
                placeholder: "add_contribution_field_name_placeholder".localized
            )

            amountView
                .fullSize()

            VStack(spacing: .medium) {
                HStack(spacing: .medium) {
                    DatePickerView(date: $viewModel.date)
                    Menu {
                        ForEach(ContributionType.allCases, id: \.self) { type in
                            Button { viewModel.type = type } label: {
                                Text(type.name)
                            }
                        }
                    } label: {
                        SmallActionButtonView(
                            style: .withValue(bgColor: viewModel.type.color),
                            icon: viewModel.type.icon,
                            text: viewModel.type.name
                        )
                    }
                    .animation(.smooth, value: viewModel.type)
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
            config: .init(yOffset: 10, animation: .smooth)
        ) { toastBanner in
            ToastBannerView(banner: toastBanner)
        }
    }
}

// MARK: - Subviews
extension AddContributionScreen {

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

}

// MARK: - Preview
#Preview {
    AddContributionScreen(goalId: "mock-1")
}
