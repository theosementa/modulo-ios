//
//  FinancialGoalDetailsIntent.swift
//  Features
//
//  Created by Theo Sementa on 06/06/2026.
//

import Foundation

enum FinancialGoalDetailsIntent {
    case bootstrap(goalId: String)
    case loadMonthlyDataPoints
    case fetchContributions
    case editTapped
    case dismissTapped
}
