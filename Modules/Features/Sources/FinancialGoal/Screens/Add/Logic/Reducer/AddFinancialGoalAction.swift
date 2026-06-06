//
//  AddFinancialGoalAction.swift
//  Features
//
//  Created by Theo Sementa on 25/03/2026.
//

import Foundation

enum AddFinancialGoalAction {
    case save(emoji: String, name: String, amount: Double, startDate: Date, endDate: Date?)
    case update(goalId: String, emoji: String, name: String, amount: Double, startDate: Date, endDate: Date?)
}
