//
//  AddFinancialGoalReducer.swift
//  Features
//
//  Created by Theo Sementa on 25/03/2026.
//

import Foundation

struct AddFinancialGoalReducer {

    func reduce(state: AddFinancialGoalState, result: AddFinancialGoalResult) -> AddFinancialGoalState {
        var newState = state

        switch result {

        case .loading:
            newState.screenState = .loading

        case .submitted:
            newState.screenState = .idle

        case .failed(let error):
            newState.screenState = .error(error)

        case let .bootstrapped(goalId, emoji, name, amount, startDate, endDate, namePlaceholder):
            newState.goalId = goalId
            newState.emoji = emoji
            newState.name = name
            newState.amount = amount
            newState.startDate = startDate
            newState.endDate = endDate
            newState.namePlaceholder = namePlaceholder

        case .emojiChanged(let emoji):
            newState.emoji = emoji

        case .nameChanged(let name):
            newState.name = name

        case .amountChanged(let amount):
            newState.amount = amount

        case .startDateChanged(let date):
            newState.startDate = date

        case .endDateChanged(let date):
            newState.endDate = date

        case .toggleEmojiPicker:
            newState.showEmojiPicker.toggle()

        case .alertLeavePresented(let isPresented):
            newState.isAlertLeavePresented = isPresented

        }

        return newState
    }

}
