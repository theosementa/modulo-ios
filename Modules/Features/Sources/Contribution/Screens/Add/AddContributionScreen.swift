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
    @State private var store: DefaultAddContributionStore = .init()
    @State private var toastBannerService = ToastBannerService.shared
    @StateObject private var keyboardManager: KeyboardManager = .init()

    // MARK: Init
    private let goalId: String
    private let contributionId: String?

    init(goalId: String, contributionId: String? = nil) {
        self.goalId = goalId
        self.contributionId = contributionId
    }

    // MARK: - View
    var body: some View {
        VStack(spacing: .standard) {
            IconButtonView(.iconXmark) {
                store.send(.dismissAttempted)
            }
            .fullWidth(.trailing)

            TextFieldView(
                text: .init(
                    get: { store.state.name },
                    set: { store.send(.nameChanged($0)) }
                ),
                title: "add_contribution_field_name_title".localized,
                placeholder: "add_contribution_field_name_placeholder".localized
            )

            amountView
                .fullSize()

            VStack(spacing: .medium) {
                HStack(spacing: .medium) {
                    DatePickerView(date: .init(
                        get: { store.state.date },
                        set: { store.send(.dateChanged($0)) }
                    ))
                    Menu {
                        ForEach(ContributionType.allCases, id: \.self) { type in
                            Button { store.send(.typeChanged(type)) } label: {
                                Text(type.name)
                            }
                        }
                    } label: {
                        SmallActionButtonView(
                            style: .withValue(bgColor: store.state.type.color),
                            icon: store.state.type.icon,
                            text: store.state.type.name
                        )
                    }
                    .animation(.smooth, value: store.state.type)
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
            store.send(.bootstrap(goalId: goalId, contributionId: contributionId))
            await observeSideEffects()
        }
    }
}

// MARK: - Subviews
extension AddContributionScreen {

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

}

// MARK: - Private methods
private extension AddContributionScreen {

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
    AddContributionScreen(goalId: "mock-1")
}
