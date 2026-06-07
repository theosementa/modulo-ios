//
//  AddFinancialGoalFlowState.swift
//  Features
//
//  Created by Theo Sementa on 06/06/2026.
//

import Foundation
import Models
import Utilities

struct AddFinancialGoalFlowState {

    enum ScreenState: Equatable {
        case idle
        case loading
        case error(String)
    }

    var screenState: ScreenState = .idle

    var currentStep: Int = 1
    // totalSteps is 3 already so FlowStepIndicator renders all future steps correctly.
    // Step 3 wiring will bump currentStep to 3; no other change needed here.
    let totalSteps: Int = 3

    var amountDraft: String = "0"
    var emoji: String = "🎯"
    var name: String = ""
    var startDate: Date = .now
    var endDate: Date = Calendar.current.date(byAdding: .year, value: 1, to: .now) ?? .now

    var showEmojiPicker: Bool = false

    // Step 3
    var startAmountDraft: String = "0"
    var trackInProgress: Bool = true
}

extension AddFinancialGoalFlowState {

    var errorMessage: String? {
        guard case .error(let error) = screenState else { return nil }
        return error
    }

    var amount: Double {
        Double(amountDraft.replacingOccurrences(of: ",", with: ".")) ?? 0
    }

    var startAmount: Double {
        Double(startAmountDraft.replacingOccurrences(of: ",", with: ".")) ?? 0
    }

    // Alias used in Step 3 context for clarity
    var step1Amount: Double { amount }

    var effectiveGoalAmount: Double {
        trackInProgress ? step1Amount : max(0, step1Amount - startAmount)
    }

    var effectiveCurrentAmount: Double {
        trackInProgress ? startAmount : 0
    }

    var shouldShowNotIncludedBanner: Bool {
        !trackInProgress && startAmount > 0
    }

    var canAdvanceFromAmount: Bool { amount > 0 }

    var canSubmit: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty && endDate > startDate
    }

    var canSubmitGoal: Bool {
        amount > 0
            && !name.trimmingCharacters(in: .whitespaces).isEmpty
            && endDate > startDate
            && (startAmount == 0 || !trackInProgress || startAmount <= step1Amount)
    }

    var previewUIModel: FinancialGoalUIModel {
        let ratio: Double = effectiveGoalAmount > 0
            ? min(max(effectiveCurrentAmount / effectiveGoalAmount, 0), 1)
            : 0
        return .init(
            id: "preview",
            name: name.isEmpty ? "—" : name,
            emoji: emoji,
            currentAmountFormatted: effectiveCurrentAmount.toCurrency(),
            goalAmountFormatted: effectiveGoalAmount.toCurrency(),
            progressPercentFormatted: "\(Int((ratio * 100).rounded())) %",
            progressRatio: ratio
        )
    }

}
