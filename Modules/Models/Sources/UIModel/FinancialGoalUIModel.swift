//
//  File.swift
//  Models
//
//  Created by Theo Sementa on 22/03/2026.
//

import Foundation

public struct FinancialGoalUIModel {
    public let id: String
    public let name: String
    public let emoji: String
    public let goalAmountFormatted: String
    public let goalDateFormatted: String?
    
    public init(
        id: String,
        name: String,
        emoji: String,
        goalAmountFormatted: String,
        goalDateFormatted: String? = nil
    ) {
        self.id = id
        self.name = name
        self.emoji = emoji
        self.goalAmountFormatted = goalAmountFormatted
        self.goalDateFormatted = goalDateFormatted
    }
}
