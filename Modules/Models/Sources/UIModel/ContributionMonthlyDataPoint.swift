//
//  ContributionMonthlyDataPoint.swift
//  Models
//
//  Created by Theo Sementa on 26/03/2026.
//

import Foundation

public struct ContributionMonthlyDataPoint: Identifiable {
    public let id: String
    public let month: Date
    public let monthLabel: String
    public let netAmount: Double

    public init(id: String, month: Date, monthLabel: String, netAmount: Double) {
        self.id = id
        self.month = month
        self.monthLabel = monthLabel
        self.netAmount = netAmount
    }
}
