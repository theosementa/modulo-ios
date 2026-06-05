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
    public let goalAmountFormatted: String
    public let goalDateFormatted: String?
    public let progressPercentFormatted: String
    public let progressRatio: Double

    public init(
        id: String,
        name: String,
        emoji: String,
        currentAmountFormatted: String,
        goalAmountFormatted: String,
        goalDateFormatted: String? = nil,
        progressPercentFormatted: String,
        progressRatio: Double
    ) {
        self.id = id
        self.name = name
        self.emoji = emoji
        self.currentAmountFormatted = currentAmountFormatted
        self.goalAmountFormatted = goalAmountFormatted
        self.goalDateFormatted = goalDateFormatted
        self.progressPercentFormatted = progressPercentFormatted
        self.progressRatio = progressRatio
    }
}
