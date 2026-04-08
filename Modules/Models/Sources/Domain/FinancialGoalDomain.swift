//
//  File.swift
//  Models
//
//  Created by Theo Sementa on 22/03/2026.
//

import Foundation
import Utilities

public struct FinancialGoalDomain: Identifiable, Equatable {
    public let id: String
    public let name: String
    public let emoji: String
    public let goalAmount: Double
    public let currentAmount: Double
    public let startDate: Date
    public let endDate: Date?

    public init(
        id: String,
        name: String,
        emoji: String,
        goalAmount: Double,
        currentAmount: Double = 0,
        startDate: Date,
        endDate: Date? = nil
    ) {
        self.id = id
        self.name = name
        self.emoji = emoji
        self.goalAmount = goalAmount
        self.currentAmount = currentAmount
        self.startDate = startDate
        self.endDate = endDate
    }
}

public extension FinancialGoalDomain {

    func toUIModel() -> FinancialGoalUIModel {
        return .init(
            id: id,
            name: name,
            emoji: emoji,
            currentAmountFormatted: currentAmount.toCurrency(),
            goalDateFormatted: endDate?.formatted(date: .numeric, time: .omitted) ?? ""
        )
    }
    
    func toEntity() -> FinancialGoalEntity {
        return .init(
            name: name,
            emoji: emoji,
            goalAmount: goalAmount,
            startDate: startDate,
            endDate: endDate
        )
    }
    
}

// MARK: - Mocks
@MainActor
public extension FinancialGoalDomain {

    static let mocks: [FinancialGoalDomain] = [
        .init(
            id: "mock-1",
            name: "mock_goal_vacation_japan".localized,
            emoji: "🗾",
            goalAmount: 3_000,
            currentAmount: 600,
            startDate: Calendar.current.date(byAdding: .month, value: -3, to: .now) ?? .now,
            endDate: Calendar.current.date(byAdding: .month, value: 8, to: .now)
        ),
        .init(
            id: "mock-2",
            name: "mock_goal_macbook".localized,
            emoji: "💻",
            goalAmount: 2_500,
            currentAmount: 1_200,
            startDate: Calendar.current.date(byAdding: .month, value: -4, to: .now) ?? .now,
            endDate: Calendar.current.date(byAdding: .month, value: 4, to: .now)
        ),
        .init(
            id: "mock-3",
            name: "mock_goal_emergency_fund".localized,
            emoji: "🛡️",
            goalAmount: 10_000,
            currentAmount: 2_500,
            startDate: Calendar.current.date(byAdding: .month, value: -6, to: .now) ?? .now
        ),
        .init(
            id: "mock-4",
            name: "mock_goal_car".localized,
            emoji: "🚗",
            goalAmount: 15_000,
            currentAmount: 3_000,
            startDate: Calendar.current.date(byAdding: .month, value: -5, to: .now) ?? .now,
            endDate: Calendar.current.date(byAdding: .year, value: 2, to: .now)
        )
    ]

}
