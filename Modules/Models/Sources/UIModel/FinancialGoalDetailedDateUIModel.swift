//
//  File.swift
//  Models
//
//  Created by Theo Sementa on 26/03/2026.
//

import Foundation

public struct FinancialGoalDetailedDateUIModel {
    public var elapsedDaysFormatted: String
    public var remainingDaysFormatted: String?
    public var startDateFormatted: String
    public var endDateFormatted: String?
    
    public init(
        elapsedDaysFormatted: String,
        remainingDaysFormatted: String? = nil,
        startDateFormatted: String,
        endDateFormatted: String? = nil
    ) {
        self.elapsedDaysFormatted = elapsedDaysFormatted
        self.remainingDaysFormatted = remainingDaysFormatted
        self.startDateFormatted = startDateFormatted
        self.endDateFormatted = endDateFormatted
    }
}
