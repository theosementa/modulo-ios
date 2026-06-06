//
//  AddFinancialGoalIntent.swift
//  Features
//
//  Created by Theo Sementa on 25/03/2026.
//

import Foundation

enum AddFinancialGoalIntent {
    case bootstrap(goalId: String?)
    
    case emojiChanged(String)
    case nameChanged(String)
    case amountChanged(String)
    case startDateChanged(Date)
    case endDateChanged(Date?)
    
    case toggleEmojiPicker
    
    case dismissAttempted
    case dismissConfirmed
    case alertLeavePresented(Bool)
    
    case save
    case update
}
