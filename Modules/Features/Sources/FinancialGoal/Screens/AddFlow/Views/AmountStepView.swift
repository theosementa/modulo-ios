//
//  AmountStepView.swift
//  Features
//
//  Created by Theo Sementa on 06/06/2026.
//

import SwiftUI
import DesignSystem
import Core
import Models

struct AmountStepView: View {

    // MARK: Dependencies
    @Bindable var store: DefaultAddFinancialGoalFlowStore

    // MARK: Environments
    @Environment(\.theme) private var theme

    // MARK: - View
    var body: some View {
        VStack(spacing: .zero) {
            Spacer()

            amountDisplayView
                .padding(.horizontal, .standard)

            Spacer()

            NumericKeyboardView(
                value: .init(
                    get: { store.state.amountDraft },
                    set: { store.send(.amountDraftChanged($0)) }
                ),
                validationAction: {
                    store.send(.advanceFromAmount)
                }
            )
            .padding(.horizontal, .standard)
            .padding(.bottom, .standard)
        }
    }
}

// MARK: - Subviews
private extension AmountStepView {

    var amountDisplayView: some View {
        VStack(spacing: .small) {
            Text("add_flow_step_amount_caption".localized)
                .font(.Label.largeMedium, color: .Text.secondary)

            HStack(spacing: .tiny) {
                Text(UserCurrency.symbol)
                    .font(.Display.smallSemiBold, color: store.state.amountDraft != "0" ? theme.color : .Text.tertiary)
                Text(store.state.amountDraft)
                    .font(.Display.extraLargeSemiBold)
                    .contentTransition(.numericText())
            }
            .animation(.smooth, value: store.state.amountDraft)
            .fullWidth()
            .overlay(alignment: .trailing) {
                DeleteNumberButtonView(amount: .init(
                    get: { store.state.amountDraft },
                    set: { store.send(.amountDraftChanged($0)) }
                ))
                .isDisplayed(store.state.amountDraft != "0")
            }
        }
    }

}

// MARK: - Preview
#Preview {
    @Previewable @State var store = DefaultAddFinancialGoalFlowStore()
    AmountStepView(store: store)
        .background(Color.Background.bg50)
}
