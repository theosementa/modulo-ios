//
//  File.swift
//  Models
//
//  Created by Theo Sementa on 22/03/2026.
//

import Foundation
import SwiftData

@Model
public final class FinancialGoalEntity {
    
    @Attribute(.unique) public var id: UUID = UUID()
    
    public var name: String
    
    public var emoji: String
    
    public var goalAmount: Double
    
    public var startDate: Date
    
    public var endDate: Date?
    
    @Relationship(deleteRule: .cascade, inverse: \ContributionEntity.financialGoal)
    public var contributions: [ContributionEntity]
    
    public init(
        name: String,
        emoji: String,
        goalAmount: Double,
        startDate: Date,
        endDate: Date? = nil,
        contributions: [ContributionEntity] = []
    ) {
        self.name = name
        self.emoji = emoji
        self.goalAmount = goalAmount
        self.startDate = startDate
        self.endDate = endDate
        self.contributions = contributions
    }
    
}

public extension FinancialGoalEntity {
    
    func toDomain() -> FinancialGoalDomain {
        return .init(
            id: id.uuidString,
            name: name,
            emoji: emoji,
            goalAmount: goalAmount,
            startDate: startDate,
            endDate: endDate
        )
    }
    
}
