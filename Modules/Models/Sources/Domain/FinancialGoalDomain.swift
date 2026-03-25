//
//  File.swift
//  Models
//
//  Created by Theo Sementa on 22/03/2026.
//

import Foundation
import Utilities

public struct FinancialGoalDomain: Identifiable {
    public let id: String
    public let name: String
    public let emoji: String
    public let goalAmount: Double
    public let goalDate: Date?
    
    public init(
        id: String,
        name: String,
        emoji: String,
        goalAmount: Double,
        goalDate: Date? = nil
    ) {
        self.id = id
        self.name = name
        self.emoji = emoji
        self.goalAmount = goalAmount
        self.goalDate = goalDate
    }
}


public extension FinancialGoalDomain {

    func toUIModel() -> FinancialGoalUIModel {
        return .init(
            id: id,
            name: name,
            emoji: emoji,
            goalAmountFormatted: goalAmount.toCurrency(),
            goalDateFormatted: goalDate?.formatted(date: .numeric, time: .omitted) ?? ""
        )
    }
    
}

// MARK: - Mocks
@MainActor
public extension FinancialGoalDomain {

    static let mock: FinancialGoalDomain = .init(
        id: "mock-1",
        name: "Preview Goal",
        emoji: "🧠",
        goalAmount: 20_000
    )

    static let mocks: [FinancialGoalDomain] = [
        .init(
            id: "mock-1",
            name: "Vacances Japon",
            emoji: "🗾",
            goalAmount: 3_000,
            goalDate: Calendar.current.date(byAdding: .month, value: 8, to: .now)
        ),
        .init(
            id: "mock-2",
            name: "MacBook Pro",
            emoji: "💻",
            goalAmount: 2_500,
            goalDate: Calendar.current.date(byAdding: .month, value: 4, to: .now)
        ),
        .init(
            id: "mock-3",
            name: "Fonds d'urgence",
            emoji: "🛡️",
            goalAmount: 10_000
        ),
        .init(
            id: "mock-4",
            name: "Voiture",
            emoji: "🚗",
            goalAmount: 15_000,
            goalDate: Calendar.current.date(byAdding: .year, value: 2, to: .now)
        ),
    ]

}
