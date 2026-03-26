//
//  File.swift
//  Models
//
//  Created by Theo Sementa on 26/03/2026.
//

import Foundation

public struct FinancialGoalDetailedUIModel {
    public var id: String
    public var name: String
    
    public var goalAmountFormatted: String
    public var currentContributionsFormatted: String
    public var remainingContributionsFormatted: String
    
    public var monthlyTargetFormatted: String?
    public var monthlyRequiredFormatted: String?
    public var contribuedThisMonthFormatted: String
    public var remainingThisMonthFormatted: String?
    
    public var date: FinancialGoalDetailedDateUIModel
    
    public init(
        id: String,
        name: String,
        goalAmountFormatted: String,
        currentContributionsFormatted: String,
        remainingContributionsFormatted: String,
        monthlyTargetFormatted: String? = nil,
        monthlyRequiredFormatted: String? = nil,
        contribuedThisMonthFormatted: String,
        remainingThisMonthFormatted: String? = nil,
        date: FinancialGoalDetailedDateUIModel
    ) {
        self.id = id
        self.name = name
        self.goalAmountFormatted = goalAmountFormatted
        self.currentContributionsFormatted = currentContributionsFormatted
        self.remainingContributionsFormatted = remainingContributionsFormatted
        self.monthlyTargetFormatted = monthlyTargetFormatted
        self.monthlyRequiredFormatted = monthlyRequiredFormatted
        self.contribuedThisMonthFormatted = contribuedThisMonthFormatted
        self.remainingThisMonthFormatted = remainingThisMonthFormatted
        self.date = date
    }
}
