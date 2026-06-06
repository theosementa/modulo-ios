//
//  AddFinancialGoalState.swift
//  Features
//
//  Created by Theo Sementa on 25/03/2026.
//

import Foundation

struct AddFinancialGoalState {

    enum ScreenState: Equatable {
        case idle
        case loading
        case error(String)
    }

    var screenState: ScreenState = .idle

    var goalId: String? = nil
    var emoji: String = "🚗"
    var name: String = ""
    var amount: String = "0"
    var startDate: Date = .now
    var endDate: Date? = nil

    var namePlaceholder: String = ""
    var isAlertLeavePresented: Bool = false
    var showEmojiPicker: Bool = false
}

extension AddFinancialGoalState {

    var errorMessage: String? {
        guard case .error(let error) = screenState else { return nil }
        return error
    }

    var isModelInCreation: Bool {
        endDate != nil
        || name.isReallyEmpty == false
        || amount.toDouble() != 0
    }

    var isEditing: Bool { goalId != nil }

}
