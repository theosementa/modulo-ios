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
public extension FinancialGoalDomain {
    
    @MainActor
    static let mock: FinancialGoalDomain = .init(
        id: UUID().uuidString,
        name: "Preview Goal",
        emoji: "🧠",
        goalAmount: 20_000
    )
    
}
