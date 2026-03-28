//
//  File.swift
//  Features
//
//  Created by Theo Sementa on 26/03/2026.
//

import Foundation
import Models
import Providers
import Core
import Stores

extension FinancialGoalDetailsScreen {
    
    @Observable @MainActor
    final class ViewModel: BaseViewModel {
        
        // MARK: Dependencies
        var goalId: String
        private let provider: FinancialGoalProvider
        private let contributionStore: ContributionStore

        // MARK: Contributions pagination
        private(set) var hasMoreContributions: Bool = true
        private var contributionsOffset: Int = 0
        private let pageSize: Int = 25

        // MARK: Chart
        var monthlyDataPoints: [ContributionMonthlyDataPoint] = []

        // MARK: Init
        init(
            id: String,
            provider: FinancialGoalProvider = DefaultFinancialGoalProvider.shared,
            contributionStore: ContributionStore = DefaultContributionStore.shared
        ) {
            self.goalId = id
            self.provider = provider
            self.contributionStore = contributionStore
        }
    }
}

// MARK: - Computed
extension FinancialGoalDetailsScreen.ViewModel {

    var detailledGoal: FinancialGoalDetailedDomain? {
        return provider.store.findOneDetailed(by: goalId)
    }

    var isChartDisplayed: Bool {
        return !monthlyDataPoints.isEmpty
    }
    
    var contributions: [ContributionDomain] {
        return contributionStore.contributions
    }

}

// MARK: - Contributions
extension FinancialGoalDetailsScreen.ViewModel {
    
    func fetchAllContributions() {
        contributionStore.fetchAll()
    }

//    func loadMoreContributions() {
//        guard hasMoreContributions else { return }
//        let page = provider.store.fetchContributions(
//            for: goalId,
//            offset: contributionsOffset,
//            limit: pageSize
//        )
//        contributions += page
//        contributionsOffset += page.count
//        hasMoreContributions = page.count == pageSize
//    }

}

// MARK: - Chart
extension FinancialGoalDetailsScreen.ViewModel {

    func loadMonthlyDataPoints() {
        monthlyDataPoints = provider.store.fetchMonthlyDataPoints(for: goalId)
    }

}
