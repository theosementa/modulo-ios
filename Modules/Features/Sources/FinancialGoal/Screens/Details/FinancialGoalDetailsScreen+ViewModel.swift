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
        private let financialGoalProvider: FinancialGoalProvider
        private let contributionProvider: ContributionProvider

        // MARK: Contributions pagination
        private(set) var hasMoreContributions: Bool = true
        private var contributionsOffset: Int = 0
        private let pageSize: Int = 25

        // MARK: Chart
        var monthlyDataPoints: [ContributionMonthlyDataPoint] = []

        // MARK: Init
        init(
            id: String,
            financialGoalProvider: FinancialGoalProvider = DefaultFinancialGoalProvider.shared,
            contributionProvider: ContributionProvider = DefaultContributionProvider.shared
        ) {
            self.goalId = id
            self.financialGoalProvider = financialGoalProvider
            self.contributionProvider = contributionProvider
        }
    }
}

// MARK: - Computed
extension FinancialGoalDetailsScreen.ViewModel {

    var detailledGoal: FinancialGoalDetailedDomain? {
        return financialGoalProvider.store.findOneDetailed(by: goalId)
    }

    var isChartDisplayed: Bool {
        return !monthlyDataPoints.isEmpty
    }
    
    var contributions: [ContributionDomain] {
        return contributionProvider.contributions(by: .mostRecent)
    }

}

// MARK: - Contributions
extension FinancialGoalDetailsScreen.ViewModel {
    
    func fetchAllContributions() {
        contributionProvider.store.fetchAll()
    }

}

// MARK: - Chart
extension FinancialGoalDetailsScreen.ViewModel {

    func loadMonthlyDataPoints() {
        monthlyDataPoints = financialGoalProvider.store.fetchMonthlyDataPoints(for: goalId)
    }

}
