//
//  DefaultAddFinancialGoalFlowStore.swift
//  Features
//
//  Created by Theo Sementa on 06/06/2026.
//

import Foundation
import DataSources
import DesignSystem
import Models
import ToastBannerKit

@Observable @MainActor
final class DefaultAddFinancialGoalFlowStore: AddFinancialGoalFlowStore, Sendable {

    private(set) var state: AddFinancialGoalFlowState
    private let reducer = AddFinancialGoalFlowReducer()
    private let dataSource: FinancialGoalDataSource

    private let _sideEffects = AsyncStream<AddFinancialGoalFlowSideEffect>.makeStream()
    var sideEffects: AsyncStream<AddFinancialGoalFlowSideEffect> { _sideEffects.stream }

    private var submitTask: Task<Void, Never>?

    init() {
        self.state = .init()
        self.dataSource = DefaultFinancialGoalDataSource.shared
    }

    // Tests
    init(state: AddFinancialGoalFlowState, dataSource: FinancialGoalDataSource = DefaultFinancialGoalDataSource.shared) {
        self.state = state
        self.dataSource = dataSource
    }

}

extension DefaultAddFinancialGoalFlowStore {

    func send(_ intent: AddFinancialGoalFlowIntent) {
        switch intent {

        case .amountDraftChanged(let draft):
            state = reducer.reduce(state: state, result: .amountDraftChanged(draft))

        case .advanceFromAmount:
            guard state.canAdvanceFromAmount else { return }
            state = reducer.reduce(state: state, result: .stepAdvanced)

        case .toggleEmojiPicker:
            state = reducer.reduce(state: state, result: .emojiPickerToggled)

        case .emojiChanged(let emoji):
            state = reducer.reduce(state: state, result: .emojiChanged(emoji))

        case .nameChanged(let name):
            state = reducer.reduce(state: state, result: .nameChanged(name))

        case .startDateChanged(let date):
            state = reducer.reduce(state: state, result: .startDateChanged(date))

        case .endDateChanged(let date):
            state = reducer.reduce(state: state, result: .endDateChanged(date))

        case .nextTapped:
            guard state.canSubmit else { return }
            state = reducer.reduce(state: state, result: .stepAdvanced)

        case .startAmountDraftChanged(let draft):
            state = reducer.reduce(state: state, result: .startAmountDraftChanged(draft))

        case .trackingToggled:
            state = reducer.reduce(state: state, result: .trackingToggled)

        case .submitTapped:
            guard state.canSubmitGoal else { return }
            submitTask?.cancel()
            submitTask = Task {
                await execute(.createGoal(
                    emoji: state.emoji,
                    name: state.name,
                    goalAmount: state.step1Amount,
                    startAmount: state.startAmount,
                    trackInProgress: state.trackInProgress,
                    startDate: state.startDate,
                    endDate: state.endDate
                ))
            }

        case .backTapped:
            state = reducer.reduce(state: state, result: .stepBack)

        case .closeTapped:
            emit(.dismiss)
        }
    }

    private func emit(_ effect: AddFinancialGoalFlowSideEffect) {
        _sideEffects.continuation.yield(effect)
    }

    private func execute(_ action: AddFinancialGoalFlowAction) async {
        switch action {
        case let .createGoal(emoji, name, goalAmount, startAmount, trackInProgress, startDate, endDate):
            state = reducer.reduce(state: state, result: .creating)
            // Clamp startAmount so it never exceeds the goal target
            let clampedStart = min(startAmount, goalAmount)
            let effectiveCurrentAmount = trackInProgress ? clampedStart : 0
            let effectiveGoalAmount = trackInProgress ? goalAmount : max(0, goalAmount - clampedStart)
            let domain = FinancialGoalDomain(
                id: "0",
                name: name,
                emoji: emoji,
                goalAmount: effectiveGoalAmount,
                currentAmount: effectiveCurrentAmount,
                startDate: startDate,
                endDate: endDate
            )
            dataSource.create(goal: domain)
            state = reducer.reduce(state: state, result: .created)
            emit(.showToast(.successGoalCreated))
            emit(.dismiss)
        }
    }

}
