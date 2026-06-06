//
//  AddFinancialGoalScreen.swift
//  Features
//
//  Created by Theo Sementa on 25/03/2026.
//

import SwiftUI
import DesignSystem
import Core
import Models
import MCEmojiPicker
import ToastBannerKit

struct AddFinancialGoalScreen: View {

    // MARK: Environments
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @Environment(\.dismiss) private var dismiss
    @Environment(\.theme) private var theme

    // MARK: States
    @State private var store: DefaultAddFinancialGoalStore
    @State private var toastBannerService = ToastBannerService.shared
    @StateObject private var keyboardManager: KeyboardManager = .init()

    // MARK: Init
    private let goalId: String?

    init(goalId: String? = nil) {
        self.goalId = goalId
        _store = State(wrappedValue: DefaultAddFinancialGoalStore())
    }

    // MARK: - View
    var body: some View {
        VStack(spacing: .standard) {
            DismissButtonView { store.send(.dismissAttempted) }
                .fullWidth(.trailing)

            VStack(spacing: .standard) {
                emojiPickerView

                TextFieldView(
                    text: .init(
                        get: { store.state.name },
                        set: { store.send(.nameChanged($0)) }
                    ),
                    title: "add_goal_field_name_title".localized,
                    placeholder: store.state.namePlaceholder.localized
                )
            }

            amountView
                .fullSize()

            VStack(spacing: .medium) {
                HStack(spacing: .medium) {
                    DatePickerView(date: .init(
                        get: { store.state.startDate },
                        set: { if let d = $0 { store.send(.startDateChanged(d)) } }
                    ))
                    DatePickerView(
                        date: .init(
                            get: { store.state.endDate },
                            set: { store.send(.endDateChanged($0)) }
                        ),
                        placeholder: "generic_end_date".localized
                    )
                }

                if keyboardManager.isKeyboardVisible {
                    Color.clear.frame(height: keyboardManager.keyboardHeight - safeAreaInsets.bottom - .standard)
                } else {
                    NumericKeyboardView(
                        value: .init(
                            get: { store.state.amount },
                            set: { store.send(.amountChanged($0)) }
                        ),
                        validationAction: {
                            store.send(store.state.isEditing ? .update : .save)
                        }
                    )
                }
            }
        }
        .padding(.standard)
        .background(Color.Background.bg50)
        .confirmationAlert(
            .leaveWithoutSaving,
            isPresented: .init(
                get: { store.state.isAlertLeavePresented },
                set: { store.send(.alertLeavePresented($0)) }
            ),
            destructiveAction: { store.send(.dismissConfirmed) }
        )
        .animation(.smooth, value: keyboardManager.isKeyboardVisible)
        .lockView()
        .navigationBarBackButtonHidden(true)
        .toastBanner(
            item: $toastBannerService.toastBanner,
            config: .init(yOffset: 10, animation: .smooth),
        ) { toastBanner in
            ToastBannerView(banner: toastBanner)
        }
        .task {
            store.send(.bootstrap(goalId: goalId))
            await observeSideEffects()
        }
    }
}

// MARK: - Subviews
extension AddFinancialGoalScreen {

    var amountView: some View {
        HStack(spacing: .tiny) {
            Text(UserCurrency.symbol)
                .font(.Display.smallSemiBold, color: store.state.amount != "0" ? theme.color : .Text.tertiary)
            Text(store.state.amount)
                .font(.Display.extraLargeSemiBold)
                .contentTransition(.numericText())
        }
        .animation(.smooth, value: store.state.amount)
        .onTapGesture { UIDevice.hideKeyboard() }
        .fullWidth()
        .overlay(alignment: .trailing) {
            DeleteNumberButtonView(amount: .init(
                get: { store.state.amount },
                set: { store.send(.amountChanged($0)) }
            ))
            .isDisplayed(store.state.amount != "0")
        }
    }

    var emojiPickerView: some View {
        Button { store.send(.toggleEmojiPicker) } label: {
            Text(store.state.emoji)
                .font(.Title.mediumMedium)
                .frame(width: 20, height: 20)
                .padding(.medium)
                .background(Color.Background.bg100, in: .rect(cornerRadius: .standard, style: .continuous))
        }
        .emojiPicker(
            isPresented: .init(
                get: { store.state.showEmojiPicker },
                set: { _ in store.send(.toggleEmojiPicker) }
            ),
            selectedEmoji: .init(
                get: { store.state.emoji },
                set: { store.send(.emojiChanged($0)) }
            )
        )
    }
}

// MARK: - Private methods
private extension AddFinancialGoalScreen {

    func observeSideEffects() async {
        for await effect in store.sideEffects {
            switch effect {
            case .dismiss:
                dismiss()
            case .showToast(let banner):
                ToastBannerService.shared.send(banner, delay: AppConstant.Animation.toastDelayAfterCloseSheet)
            case .presentLeaveAlert:
                store.send(.alertLeavePresented(true))
            }
        }
    }

}

// MARK: - Preview
#Preview {
    AddFinancialGoalScreen()
}
