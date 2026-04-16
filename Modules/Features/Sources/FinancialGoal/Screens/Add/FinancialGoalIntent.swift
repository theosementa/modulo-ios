//
//  File.swift
//  Features
//
//  Created by Theo Sementa on 16/04/2026.
//

import Foundation

enum FinancialGoalIntent {
    case emojiChanged(String)
    case nameChanged(String)
    case amountChanged(Double)
    case startDateChanged(Date)
    case endDateChanged(Date)
    case save
}
