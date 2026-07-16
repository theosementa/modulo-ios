//
//  AddFinancialGoalFlowScreen.swift
//  Features
//
//  Created by Theo Sementa on 06/06/2026.
//

import SwiftUI
import DesignSystem
import ToastBannerKit

struct AddFinancialGoalFlowScreen: View {

    // MARK: States
    @State private var store = DefaultAddFinancialGoalFlowStore()

    // MARK: Environments
    @Environment(\.dismiss) private var dismiss

    // MARK: - View
    var body: some View {
        VStack(spacing: .zero) {
            topBarView
                .padding(.horizontal, .standard)
                .padding(.top, .standard)

            FlowStepIndicator(currentStep: store.state.currentStep, totalSteps: store.state.totalSteps)
                .padding(.horizontal, .standard)
                .padding(.top, .medium)

            stepView
                .animation(.smooth, value: store.state.currentStep)
        }
        .background(Color.Background.bg50.ignoresSafeArea())
        .task { await observeSideEffects() }
    }
}

// MARK: - Subviews
private extension AddFinancialGoalFlowScreen {

    var topBarView: some View {
        HStack {
            if store.state.currentStep > 1 {
                IconButtonView(.iconChevronLeft) {
                    store.send(.backTapped)
                }
            }
            Spacer()
            IconButtonView(.iconXmark) {
                store.send(.closeTapped)
            }
        }
    }

    @ViewBuilder
    var stepView: some View {
        switch store.state.currentStep {
        case 1:
            AmountStepView(store: store)
        case 2:
            InformationStepView(store: store)
        case 3:
            StartAmountStepView(store: store)
        default:
            EmptyView()
        }
    }

}

// MARK: - Private methods
private extension AddFinancialGoalFlowScreen {

    func observeSideEffects() async {
        for await effect in store.sideEffects {
            switch effect {
            case .dismiss:
                dismiss()
            case .showToast(let model):
                ToastBannerService.shared.send(model)
            }
        }
    }

}

// MARK: - Preview
#Preview("Step 1") {
    AddFinancialGoalFlowScreen()
}

#Preview("Step 2") {
    var state = AddFinancialGoalFlowState()
    state.amountDraft = "5000"
    state.currentStep = 2
    return InformationStepView(store: DefaultAddFinancialGoalFlowStore(state: state))
        .background(Color.Background.bg50)
}
