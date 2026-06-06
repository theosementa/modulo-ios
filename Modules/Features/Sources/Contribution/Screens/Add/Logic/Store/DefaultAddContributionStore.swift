//
//  DefaultAddContributionStore.swift
//  Features
//
//  Created by Theo Sementa on 06/06/2026.
//

import Foundation
import Models
import DataSources
import ToastBannerKit

@Observable @MainActor
final class DefaultAddContributionStore: AddContributionStore, Sendable {

    private(set) var state: AddContributionState
    private let reducer = AddContributionReducer()
    private let contributionDataSource: ContributionDataSource
    private let financialGoalDataSource: FinancialGoalDataSource

    private let _sideEffects = AsyncStream<AddContributionSideEffect>.makeStream()
    var sideEffects: AsyncStream<AddContributionSideEffect> { _sideEffects.stream }

    private var submitTask: Task<Void, Never>?

    init() {
        self.state = .init()
        self.contributionDataSource = DefaultContributionDataSource.shared
        self.financialGoalDataSource = DefaultFinancialGoalDataSource.shared
    }

    // Tests
    init(
        state: AddContributionState,
        contributionDataSource: ContributionDataSource,
        financialGoalDataSource: FinancialGoalDataSource
    ) {
        self.state = state
        self.contributionDataSource = contributionDataSource
        self.financialGoalDataSource = financialGoalDataSource
    }

}

extension DefaultAddContributionStore {

    func send(_ intent: AddContributionIntent) {
        switch intent {

        case let .bootstrap(goalId, contributionId):
            if let contributionId, let existing = contributionDataSource.findOneBy(contributionId) {
                state = reducer.reduce(
                    state: state, result: .bootstrapped(
                        goalId: goalId,
                        contributionId: contributionId,
                        name: existing.name ?? "",
                        amount: existing.amount.toString(),
                        date: existing.date,
                        type: existing.type
                    )
                )
            } else {
                state = reducer.reduce(
                    state: state, result: .bootstrapped(
                        goalId: goalId,
                        contributionId: nil,
                        name: state.name,
                        amount: state.amount,
                        date: state.date,
                        type: state.type
                    )
                )
            }

        case .nameChanged(let name):
            state = reducer.reduce(state: state, result: .nameChanged(name))

        case .amountChanged(let amount):
            state = reducer.reduce(state: state, result: .amountChanged(amount))

        case .dateChanged(let date):
            state = reducer.reduce(state: state, result: .dateChanged(date))

        case .typeChanged(let type):
            state = reducer.reduce(state: state, result: .typeChanged(type))

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
                    goalId: state.goalId,
                    name: state.name,
                    amount: state.amount.toDouble(),
                    type: state.type,
                    date: state.date ?? .now
                ))
            }

        case .update:
            guard let contributionId = state.contributionId else { return }
            submitTask?.cancel()
            submitTask = Task {
                await execute(.update(
                    contributionId: contributionId,
                    goalId: state.goalId,
                    name: state.name,
                    amount: state.amount.toDouble(),
                    type: state.type,
                    date: state.date ?? .now
                ))
            }
        }
    }

    private func emit(_ effect: AddContributionSideEffect) {
        _sideEffects.continuation.yield(effect)
    }

    private func execute(_ action: AddContributionAction) async {
        switch action {

        case let .save(goalId, name, amount, type, date):
            do {
                try checkDatas(amount: amount)
                state = reducer.reduce(state: state, result: .loading)
                let contribution = ContributionDomain(
                    id: "0",
                    goalId: goalId,
                    name: name.isReallyEmpty ? nil : name,
                    amount: amount,
                    type: type,
                    date: date
                )
                contributionDataSource.create(contribution: contribution)
                state = reducer.reduce(state: state, result: .submitted)
                emit(.dismiss)
                emit(.showToast(.successContributionAdded))
            } catch let error as AddContributionError {
                state = reducer.reduce(state: state, result: .failed(error.description))
                emit(.showToast(toastBannerFor(error)))
            } catch {
                state = reducer.reduce(state: state, result: .failed(error.localizedDescription))
            }

        case let .update(contributionId, goalId, name, amount, type, date):
            do {
                try checkDatas(amount: amount)
                state = reducer.reduce(state: state, result: .loading)
                let contribution = ContributionDomain(
                    id: contributionId,
                    goalId: goalId,
                    name: name.isReallyEmpty ? nil : name,
                    amount: amount,
                    type: type,
                    date: date
                )
                contributionDataSource.update(contribution: contribution)
                state = reducer.reduce(state: state, result: .submitted)
                emit(.dismiss)
                emit(.showToast(.successContributionUpdated))
            } catch let error as AddContributionError {
                state = reducer.reduce(state: state, result: .failed(error.description))
                emit(.showToast(toastBannerFor(error)))
            } catch {
                state = reducer.reduce(state: state, result: .failed(error.localizedDescription))
            }
        }
    }

    private func checkDatas(amount: Double) throws {
        if amount == 0 {
            throw AddContributionError.missingAmount
        }
    }

    private func toastBannerFor(_ error: AddContributionError) -> ToastBannerUIModel {
        switch error {
        case .missingAmount:
            return .errorAmountMandatory
        case .persistenceFailed:
            return .errorAmountMandatory
        }
    }

}
