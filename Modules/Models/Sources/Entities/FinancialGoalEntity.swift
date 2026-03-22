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
    
    public var goalDate: Date?
    
    @Relationship(deleteRule: .cascade, inverse: \ContributionEntity.financialGoal)
    public var contributions: [ContributionEntity]
    
    public init(
        name: String,
        emoji: String,
        goalAmount: Double,
        goalDate: Date? = nil,
        contributions: [ContributionEntity] = []
    ) {
        self.name = name
        self.emoji = emoji
        self.goalAmount = goalAmount
        self.goalDate = goalDate
        self.contributions = contributions
    }
    
}
