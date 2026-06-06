//
//  DefaultFinancialGoalDetailsStore.swift
//  Features
//
//  Created by Theo Sementa on 06/06/2026.
//

import Foundation
import Models
import Presenters

@Observable @MainActor
final class DefaultFinancialGoalDetailsStore: FinancialGoalDetailsStore {

    private(set) var state: FinancialGoalDetailsState
    private let reducer = FinancialGoalDetailsReducer()
    private let financialGoalPresenter: FinancialGoalPresenter
    private let contributionPresenter: ContributionPresenter

    private let _sideEffects = AsyncStream<FinancialGoalDetailsSideEffect>.makeStream()
    var sideEffects: AsyncStream<FinancialGoalDetailsSideEffect> { _sideEffects.stream }

    init(
        financialGoalPresenter: FinancialGoalPresenter = DefaultFinancialGoalPresenter.shared,
        contributionPresenter: ContributionPresenter = DefaultContributionPresenter.shared
    ) {
        self.state = .init()
        self.financialGoalPresenter = financialGoalPresenter
        self.contributionPresenter = contributionPresenter
    }

    // Tests
    init(
        state: FinancialGoalDetailsState,
        financialGoalPresenter: FinancialGoalPresenter,
        contributionPresenter: ContributionPresenter
    ) {
        self.state = state
        self.financialGoalPresenter = financialGoalPresenter
        self.contributionPresenter = contributionPresenter
    }

    var detailledGoal: FinancialGoalDetailedDomain? {
        financialGoalPresenter.dataSource.findOneDetailed(by: state.goalId)
    }

    var contributions: [ContributionDomain] {
        contributionPresenter.contributions(sortedBy: .date)
    }

}

extension DefaultFinancialGoalDetailsStore {

    func send(_ intent: FinancialGoalDetailsIntent) {
        switch intent {

        case .bootstrap(let goalId):
            state = reducer.reduce(state: state, result: .bootstrapped(goalId: goalId))

        case .loadMonthlyDataPoints:
            let points = financialGoalPresenter.dataSource.fetchMonthlyDataPoints(for: state.goalId)
            state = reducer.reduce(state: state, result: .monthlyDataPointsLoaded(points))

        case .fetchContributions:
            contributionPresenter.dataSource.fetchAll(addToRepo: true)

        case .editTapped:
            emit(.navigateToEdit(goalId: state.goalId))

        case .dismissTapped:
            emit(.dismiss)
        }
    }

    private func emit(_ effect: FinancialGoalDetailsSideEffect) {
        _sideEffects.continuation.yield(effect)
    }

}
