//
//  FinancialGoalDetailedDomain.swift
//  Models
//
//  Created by Theo Sementa on 26/03/2026.
//

import Foundation

public struct FinancialGoalDetailedDomain {
    public let goal: FinancialGoalDomain
    public let contributions: [ContributionDomain]

    public init(goal: FinancialGoalDomain, contributions: [ContributionDomain]) {
        self.goal = goal
        self.contributions = contributions
    }
}

// MARK: - Computed Stats
public extension FinancialGoalDetailedDomain {

    /// Ratio d'avancement entre 0.0 et 1.0
    var progressRatio: Double {
        guard goal.goalAmount > 0 else { return 0 }
        return min(goal.currentAmount / goal.goalAmount, 1.0)
    }

    /// Nombre de jours restants avant la date de fin
    var remainingDays: Int? {
        guard let endDate = goal.endDate else { return nil }
        let days = Calendar.current.dateComponents([.day], from: .now, to: endDate).day ?? 0
        return max(0, days)
    }

    /// Montant mensuel à contribuer pour atteindre l'objectif à temps
    var monthlyRequired: Double? {
        guard let endDate = goal.endDate else { return nil }
        let remaining = goal.goalAmount - goal.currentAmount
        guard remaining > 0 else { return 0 }
        let months = Calendar.current.dateComponents([.month], from: .now, to: endDate).month ?? 0
        guard months > 0 else { return nil }
        return remaining / Double(months)
    }

    /// Date de fin estimée basée sur le rythme moyen de contribution
    var projectedEndDate: Date? {
        let remaining = goal.goalAmount - goal.currentAmount
        guard remaining > 0 else { return .now }
        let monthsElapsed = max(
            1,
            Calendar.current.dateComponents([.month], from: goal.startDate, to: .now).month ?? 1
        )
        let monthlyAverage = goal.currentAmount / Double(monthsElapsed)
        guard monthlyAverage > 0 else { return nil }
        let monthsNeeded = Int(ceil(remaining / monthlyAverage))
        return Calendar.current.date(byAdding: .month, value: monthsNeeded, to: .now)
    }

}

// MARK: - Mocks
@MainActor
public extension FinancialGoalDetailedDomain {

    static let mock: FinancialGoalDetailedDomain = .init(
        goal: .mocks[0],
        contributions: ContributionDomain.mocks
    )

}
