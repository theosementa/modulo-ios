//
//  FinancialGoalDetailedDomain.swift
//  Models
//
//  Created by Theo Sementa on 26/03/2026.
//

import Foundation
import Utilities

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

    var progressRatio: Double {
        guard goal.goalAmount > 0 else { return 0 }
        return min(goal.currentAmount / goal.goalAmount, 1.0)
    }

    var remainingDays: Int? {
        guard let endDate = goal.endDate else { return nil }
        let days = Calendar.current.dateComponents([.day], from: .now, to: endDate).day ?? 0
        return max(0, days)
    }

    var monthlyRequired: Double? {
        guard let endDate = goal.endDate else { return nil }
        
        let remaining = goal.goalAmount - goal.currentAmount
        guard remaining > 0 else { return 0 }
        
        let months = Calendar.current.months(between: .now, and: endDate)
        
        guard months > 0 else { return nil }
        
        return remaining / Double(months)
    }

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

// MARK: - Mapping
public extension FinancialGoalDetailedDomain {

    func toUIModel() -> FinancialGoalDetailedUIModel {
        let calendar = Calendar.current

        let elapsedDays = max(0, calendar.dateComponents([.day], from: goal.startDate, to: .now).day ?? 0)

        let monthlyTarget: Double? = {
            guard let endDate = goal.endDate else { return nil }
            let startMonth = calendar.dateComponents([.year, .month], from: goal.startDate)
            let endMonth = calendar.dateComponents([.year, .month], from: endDate)
            
            guard
                let startMonthDate = calendar.date(from: startMonth),
                let endMonthDate = calendar.date(from: endMonth)
            else { return nil }
            
            let totalMonths = calendar.months(between: startMonthDate, and: endMonthDate)
            guard totalMonths > 0 else { return nil }
            
            return goal.goalAmount / Double(totalMonths)
        }()

        let contributedThisMonth = contributions
            .filter { calendar.isDate($0.date, equalTo: .now, toGranularity: .month) }
            .reduce(0.0) { result, contribution in
                contribution.type == .add ? result + contribution.amount : result - contribution.amount
            }

        let remainingThisMonth: Double? = monthlyRequired.map { max(0, $0 - contributedThisMonth) }

        let dateModel = FinancialGoalDetailedDateUIModel(
            elapsedDaysFormatted: "\(elapsedDays)",
            remainingDaysFormatted: remainingDays.map { "\($0)" },
            startDateFormatted: goal.startDate.formatted(.dateTime.day().month(.abbreviated).year()),
            endDateFormatted: goal.endDate?.formatted(.dateTime.day().month(.abbreviated).year())
        )

        return FinancialGoalDetailedUIModel(
            id: goal.id,
            name: goal.emoji + goal.name,
            progress: progressRatio,
            goalAmountFormatted: goal.goalAmount.toCurrency(),
            currentContributionsFormatted: goal.currentAmount.toCurrency(),
            remainingContributionsFormatted: max(0, goal.goalAmount - goal.currentAmount).toCurrency(),
            monthlyTargetFormatted: monthlyTarget?.toCurrency(),
            monthlyRequiredFormatted: monthlyRequired?.toCurrency(),
            contribuedThisMonthFormatted: contributedThisMonth.toCurrency(),
            remainingThisMonthFormatted: remainingThisMonth?.toCurrency(),
            date: dateModel
        )
    }

}

// MARK: - Mocks
@MainActor
public extension FinancialGoalDetailedDomain {

    static let mock: FinancialGoalDetailedDomain = .init(
        goal: .mocks[0],
        contributions: ContributionDomain.mocks(for: FinancialGoalDomain.mocks[0].id)
    )

}
