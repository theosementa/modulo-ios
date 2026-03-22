//
//  File.swift
//  Models
//
//  Created by Theo Sementa on 22/03/2026.
//

import Foundation

public struct FinancialGoalDomain: Identifiable {
    public let id: UUID
    public let name: String
    public let emoji: String
    public let goalAmount: Double
}
