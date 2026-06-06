//
//  AddFinancialGoalResult.swift
//  Features
//
//  Created by Theo Sementa on 25/03/2026.
//

import Foundation

enum AddFinancialGoalResult {
    case loading
    case submitted
    case failed(String)

    case bootstrapped(goalId: String?, emoji: String, name: String, amount: String, startDate: Date, endDate: Date?, namePlaceholder: String)
    case emojiChanged(String)
    case nameChanged(String)
    case amountChanged(String)
    case startDateChanged(Date)
    case endDateChanged(Date?)
    case toggleEmojiPicker
    case alertLeavePresented(Bool)
}
