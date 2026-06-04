//
//  File.swift
//  Features
//
//  Created by Theo Sementa on 17/04/2026.
//

import Foundation

enum AddFinancialGoalAction {
    case save(emoji: String, name: String, amount: Double, startDate: Date, endDate: Date?)
    case update(emoji: String, name: String, amount: Double, startDate: Date, endDate: Date?)
}
