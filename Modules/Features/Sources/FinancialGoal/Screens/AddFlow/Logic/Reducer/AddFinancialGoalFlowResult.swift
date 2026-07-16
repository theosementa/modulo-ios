//
//  AddFinancialGoalFlowResult.swift
//  Features
//
//  Created by Theo Sementa on 06/06/2026.
//

import Foundation

enum AddFinancialGoalFlowResult {
    case amountDraftChanged(String)
    case stepAdvanced
    case stepBack

    case emojiChanged(String)
    case nameChanged(String)
    case startDateChanged(Date)
    case endDateChanged(Date)
    case emojiPickerToggled

    case startAmountDraftChanged(String)
    case trackingToggled
    case creating
    case created
    case creationFailed(String)
}
