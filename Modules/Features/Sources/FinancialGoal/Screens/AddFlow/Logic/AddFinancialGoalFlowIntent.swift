//
//  AddFinancialGoalFlowIntent.swift
//  Features
//
//  Created by Theo Sementa on 06/06/2026.
//

import Foundation

enum AddFinancialGoalFlowIntent {
    // NumericKeyboardView writes the full updated draft string via binding
    case amountDraftChanged(String)
    case advanceFromAmount

    case toggleEmojiPicker
    case emojiChanged(String)
    case nameChanged(String)
    case startDateChanged(Date)
    case endDateChanged(Date)
    case nextTapped

    case startAmountDraftChanged(String)
    case trackingToggled
    case submitTapped

    case backTapped
    case closeTapped
}
