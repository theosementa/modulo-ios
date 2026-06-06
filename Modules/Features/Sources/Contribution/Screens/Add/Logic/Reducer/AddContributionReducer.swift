//
//  AddContributionReducer.swift
//  Features
//
//  Created by Theo Sementa on 06/06/2026.
//

import Foundation

struct AddContributionReducer {

    func reduce(state: AddContributionState, result: AddContributionResult) -> AddContributionState {
        var newState = state

        switch result {

        case .loading:
            newState.screenState = .loading

        case .submitted:
            newState.screenState = .idle

        case .failed(let error):
            newState.screenState = .error(error)

        case let .bootstrapped(goalId, contributionId, name, amount, date, type):
            newState.goalId = goalId
            newState.contributionId = contributionId
            newState.name = name
            newState.amount = amount
            newState.date = date
            newState.type = type

        case .nameChanged(let name):
            newState.name = name

        case .amountChanged(let amount):
            newState.amount = amount

        case .dateChanged(let date):
            newState.date = date

        case .typeChanged(let type):
            newState.type = type

        case .alertLeavePresented(let isPresented):
            newState.isAlertLeavePresented = isPresented

        }

        return newState
    }

}
