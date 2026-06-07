//
//  DefaultAddFinancialGoalStore.swift
//  Features
//
//  Created by Theo Sementa on 25/03/2026.
//

import Foundation
import Models
import DataSources
import DesignSystem
import ToastBannerKit

@Observable @MainActor
final class DefaultAddFinancialGoalStore: AddFinancialGoalStore {

    private(set) var state: AddFinancialGoalState
    private let reducer = AddFinancialGoalReducer()
    private let dataSource: FinancialGoalDataSource

    private let _sideEffects = AsyncStream<AddFinancialGoalSideEffect>.makeStream()
    var sideEffects: AsyncStream<AddFinancialGoalSideEffect> { _sideEffects.stream }

    private var submitTask: Task<Void, Never>?

    init() {
        self.state = .init()
        self.dataSource = DefaultFinancialGoalDataSource.shared
    }

    // Tests
    init(
        state: AddFinancialGoalState,
        dataSource: FinancialGoalDataSource
    ) {
        self.state = state
        self.dataSource = dataSource
    }

}

extension DefaultAddFinancialGoalStore {

    func send(_ intent: AddFinancialGoalIntent) {
        switch intent {

        case .bootstrap(let goalId):
            let placeholder = randomPlaceholder()
            if let goalId, let existing = dataSource.findOne(by: goalId) {
                state = reducer.reduce(
                    state: state, result: .bootstrapped(
                        goalId: goalId,
                        emoji: existing.emoji,
                        name: existing.name,
                        amount: existing.goalAmount.toString(),
                        startDate: existing.startDate,
                        endDate: existing.endDate,
                        namePlaceholder: placeholder
                    )
                )
            } else {
                state = reducer.reduce(
                    state: state, result: .bootstrapped(
                        goalId: nil,
                        emoji: state.emoji,
                        name: state.name,
                        amount: state.amount,
                        startDate: state.startDate,
                        endDate: state.endDate,
                        namePlaceholder: placeholder
                    )
                )
            }

        case .emojiChanged(let emoji):
            state = reducer.reduce(state: state, result: .emojiChanged(emoji))

        case .nameChanged(let name):
            state = reducer.reduce(state: state, result: .nameChanged(name))

        case .amountChanged(let amount):
            state = reducer.reduce(state: state, result: .amountChanged(amount))

        case .startDateChanged(let date):
            state = reducer.reduce(state: state, result: .startDateChanged(date))

        case .endDateChanged(let date):
            state = reducer.reduce(state: state, result: .endDateChanged(date))

        case .toggleEmojiPicker:
            state = reducer.reduce(state: state, result: .toggleEmojiPicker)

        case .dismissAttempted:
            if state.isModelInCreation {
                emit(.presentLeaveAlert)
            } else {
                emit(.dismiss)
            }

        case .dismissConfirmed:
            emit(.dismiss)

        case .alertLeavePresented(let isPresented):
            state = reducer.reduce(state: state, result: .alertLeavePresented(isPresented))

        case .save:
            submitTask?.cancel()
            submitTask = Task {
                await execute(.save(
                    emoji: state.emoji,
                    name: state.name,
                    amount: state.amount.toDouble(),
                    startDate: state.startDate,
                    endDate: state.endDate
                ))
            }

        case .update:
            guard let goalId = state.goalId else { return }
            submitTask?.cancel()
            submitTask = Task {
                await execute(.update(
                    goalId: goalId,
                    emoji: state.emoji,
                    name: state.name,
                    amount: state.amount.toDouble(),
                    startDate: state.startDate,
                    endDate: state.endDate
                ))
            }
        }
    }

    private func emit(_ effect: AddFinancialGoalSideEffect) {
        _sideEffects.continuation.yield(effect)
    }

    private func execute(_ action: AddFinancialGoalAction) async {
        switch action {

        case let .save(emoji, name, amount, startDate, endDate):
            do {
                try checkDatas(name: name, amount: amount)
                state = reducer.reduce(state: state, result: .loading)
                let domain = FinancialGoalDomain(
                    id: "0",
                    name: name,
                    emoji: emoji,
                    goalAmount: amount,
                    startDate: startDate,
                    endDate: endDate
                )
                dataSource.create(goal: domain)
                state = reducer.reduce(state: state, result: .submitted)
                emit(.dismiss)
                emit(.showToast(.successGoalCreated))
            } catch let error as AddFinancialGoalError {
                state = reducer.reduce(state: state, result: .failed(error.description))
                emit(.showToast(toastBannerFor(error)))
            } catch {
                state = reducer.reduce(state: state, result: .failed(error.localizedDescription))
            }

        case let .update(goalId, emoji, name, amount, startDate, endDate):
            do {
                try checkDatas(name: name, amount: amount)
                state = reducer.reduce(state: state, result: .loading)
                let domain = FinancialGoalDomain(
                    id: goalId,
                    name: name,
                    emoji: emoji,
                    goalAmount: amount,
                    startDate: startDate,
                    endDate: endDate
                )
                dataSource.update(goal: domain)
                state = reducer.reduce(state: state, result: .submitted)
                emit(.dismiss)
                emit(.showToast(.successGoalUpdated))
            } catch let error as AddFinancialGoalError {
                state = reducer.reduce(state: state, result: .failed(error.description))
                emit(.showToast(toastBannerFor(error)))
            } catch {
                state = reducer.reduce(state: state, result: .failed(error.localizedDescription))
            }
        }
    }

    private func checkDatas(name: String, amount: Double) throws {
        if name.isReallyEmpty {
            throw AddFinancialGoalError.missingName
        }
        if amount == 0 {
            throw AddFinancialGoalError.missingAmount
        }
    }

    private func toastBannerFor(_ error: AddFinancialGoalError) -> ToastBannerUIModel {
        switch error {
        case .missingName:
            return .errorNameMandatory
        case .missingAmount:
            return .errorAmountMandatory
        case .persistenceFailed:
            return .errorNameMandatory
        }
    }

    private func randomPlaceholder() -> String {
        let placeholders: [String] = [
            "add_financial_goal_field_name_placeholder_one",
            "add_financial_goal_field_name_placeholder_two",
            "add_financial_goal_field_name_placeholder_three",
            "add_financial_goal_field_name_placeholder_four",
            "add_financial_goal_field_name_placeholder_five"
        ]
        return placeholders.randomElement() ?? ""
    }

}
