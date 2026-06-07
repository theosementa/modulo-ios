//
//  StartAmountStepView.swift
//  Features
//
//  Created by Theo Sementa on 07/06/2026.
//

import SwiftUI
import DesignSystem
import Core
import Models

struct StartAmountStepView: View {

    // MARK: Dependencies
    @Bindable var store: DefaultAddFinancialGoalFlowStore

    // MARK: Environments
    @Environment(\.theme) private var theme

    // MARK: - View
    var body: some View {
        VStack(spacing: .zero) {
            scrollableContent

            NumericKeyboardView(
                value: .init(
                    get: { store.state.startAmountDraft },
                    set: { store.send(.startAmountDraftChanged($0)) }
                ),
                validationAction: {
                    store.send(.submitTapped)
                }
            )
            .padding(.horizontal, .standard)
            .padding(.bottom, .standard)
        }
    }
}

// MARK: - Subviews
private extension StartAmountStepView {

    var scrollableContent: some View {
        ScrollView {
            VStack(spacing: .large) {
                goalPreviewCard
                    .padding(.horizontal, .standard)

                if store.state.shouldShowNotIncludedBanner {
                    notIncludedBanner
                        .padding(.horizontal, .standard)
                }

                startAmountDisplayView
                    .padding(.horizontal, .standard)

                if store.state.startAmount > 0 {
                    trackToggleRow
                        .padding(.horizontal, .standard)
                }
            }
            .padding(.vertical, .standard)
        }
        .scrollBounceBehavior(.basedOnSize)
    }

    var goalPreviewCard: some View {
        FinancialGoalRowView(
            item: store.state.previewUIModel,
            style: .detailed
        )
    }

    var notIncludedBanner: some View {
        HStack(spacing: .small) {
            IconView(.iconWarning, size: .medium, color: .Text.secondary)
            Text(
                String(
                    format: "add_flow_step_start_amount_not_tracked_banner".localized,
                    store.state.startAmount.toCurrency()
                )
            )
            .font(.Label.largeMedium, color: .Text.secondary)
            .fullWidth(.leading)
        }
        .padding(.standard)
        .background(Color.Background.bg100, in: .rect(cornerRadius: .standard, style: .continuous))
    }

    var startAmountDisplayView: some View {
        VStack(spacing: .small) {
            Text("add_flow_step_start_amount_caption".localized)
                .font(.Label.largeMedium, color: .Text.secondary)

            HStack(spacing: .tiny) {
                Text(UserCurrency.symbol)
                    .font(.Display.smallSemiBold, color: store.state.startAmountDraft != "0" ? theme.color : .Text.tertiary)
                Text(store.state.startAmountDraft)
                    .font(.Display.extraLargeSemiBold)
                    .contentTransition(.numericText())
            }
            .animation(.smooth, value: store.state.startAmountDraft)
            .fullWidth()
            .overlay(alignment: .trailing) {
                DeleteNumberButtonView(amount: .init(
                    get: { store.state.startAmountDraft },
                    set: { store.send(.startAmountDraftChanged($0)) }
                ))
                .isDisplayed(store.state.startAmountDraft != "0")
            }
        }
    }

    var trackToggleRow: some View {
        HStack(spacing: .medium) {
            IconView(.iconTarget, size: .medium, color: .Text.primary)
            Text("add_flow_step_start_amount_track_toggle".localized)
                .font(.Body.mediumMedium, color: .Text.primary)
                .fullWidth(.leading)
            Toggle(
                "",
                isOn: .init(
                    get: { store.state.trackInProgress },
                    set: { _ in store.send(.trackingToggled) }
                )
            )
            .labelsHidden()
        }
        .padding(.standard)
        .background(Color.Background.bg100, in: .rect(cornerRadius: .standard, style: .continuous))
    }

}

// MARK: - Preview
#Preview("Empty") {
    @Previewable @State var store = DefaultAddFinancialGoalFlowStore(
        state: {
            var s = AddFinancialGoalFlowState()
            s.amountDraft = "50000"
            s.name = "House down payment"
            s.emoji = "🏡"
            s.currentStep = 3
            return s
        }()
    )
    VStack(spacing: .zero) {
        StartAmountStepView(store: store)
    }
    .background(Color.Background.bg50)
}

#Preview("Included") {
    @Previewable @State var store = DefaultAddFinancialGoalFlowStore(
        state: {
            var s = AddFinancialGoalFlowState()
            s.amountDraft = "50000"
            s.startAmountDraft = "22000"
            s.trackInProgress = true
            s.name = "House down payment"
            s.emoji = "🏡"
            s.currentStep = 3
            return s
        }()
    )
    VStack(spacing: .zero) {
        StartAmountStepView(store: store)
    }
    .background(Color.Background.bg50)
}

#Preview("Not Included") {
    @Previewable @State var store = DefaultAddFinancialGoalFlowStore(
        state: {
            var s = AddFinancialGoalFlowState()
            s.amountDraft = "50000"
            s.startAmountDraft = "22000"
            s.trackInProgress = false
            s.name = "House down payment"
            s.emoji = "🏡"
            s.currentStep = 3
            return s
        }()
    )
    VStack(spacing: .zero) {
        StartAmountStepView(store: store)
    }
    .background(Color.Background.bg50)
}
