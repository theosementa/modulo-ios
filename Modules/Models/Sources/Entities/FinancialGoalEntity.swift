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
    
    @Attribute(.unique) var id: UUID = UUID()
    
    var name: String
    
    var emoji: String
    
    var goalAmount: Double
    
    var goalDate: Date?
    
    @Relationship(deleteRule: .cascade, inverse: \ContributionEntity.financialGoal)
    public var contributions: [ContributionEntity]?
    
    public init(
        name: String,
        emoji: String,
        goalAmount: Double,
        goalDate: Date? = nil,
        contributions: [ContributionEntity]? = nil
    ) {
        self.id = id
        self.name = name
        self.emoji = emoji
        self.goalAmount = goalAmount
        self.goalDate = goalDate
        self.contributions = contributions
    }
    
}
