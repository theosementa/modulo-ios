//
//  AddFinancialGoalFlowAction.swift
//  Features
//
//  Created by Theo Sementa on 07/06/2026.
//

import Foundation

enum AddFinancialGoalFlowAction {
    case createGoal(
        emoji: String,
        name: String,
        goalAmount: Double,
        startAmount: Double,
        trackInProgress: Bool,
        startDate: Date,
        endDate: Date
    )
}
