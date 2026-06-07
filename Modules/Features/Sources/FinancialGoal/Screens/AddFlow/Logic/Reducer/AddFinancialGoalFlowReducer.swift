//
//  AddFinancialGoalFlowReducer.swift
//  Features
//
//  Created by Theo Sementa on 06/06/2026.
//

import Foundation

struct AddFinancialGoalFlowReducer {

    func reduce(state: AddFinancialGoalFlowState, result: AddFinancialGoalFlowResult) -> AddFinancialGoalFlowState {
        var newState = state

        switch result {
        case .amountDraftChanged(let draft):
            newState.amountDraft = draft

        case .stepAdvanced:
            newState.currentStep = min(state.currentStep + 1, state.totalSteps)

        case .stepBack:
            newState.currentStep = max(state.currentStep - 1, 1)

        case .emojiChanged(let emoji):
            newState.emoji = emoji

        case .nameChanged(let name):
            newState.name = name

        case .startDateChanged(let date):
            newState.startDate = date

        case .endDateChanged(let date):
            newState.endDate = date

        case .emojiPickerToggled:
            newState.showEmojiPicker.toggle()

        case .startAmountDraftChanged(let draft):
            newState.startAmountDraft = draft

        case .trackingToggled:
            newState.trackInProgress.toggle()

        case .creating:
            newState.screenState = .loading

        case .created:
            newState.screenState = .idle

        case .creationFailed(let error):
            newState.screenState = .error(error)
        }

        return newState
    }

}
