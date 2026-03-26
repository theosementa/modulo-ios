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
    public let currentAmountFormatted: String
    public let goalDateFormatted: String?
    
    public init(
        id: String,
        name: String,
        emoji: String,
        currentAmountFormatted: String,
        goalDateFormatted: String? = nil
    ) {
        self.id = id
        self.name = name
        self.emoji = emoji
        self.currentAmountFormatted = currentAmountFormatted
        self.goalDateFormatted = goalDateFormatted
    }
}
