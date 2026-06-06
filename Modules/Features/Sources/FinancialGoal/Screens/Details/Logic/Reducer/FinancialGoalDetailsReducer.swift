//
//  FinancialGoalDetailsReducer.swift
//  Features
//
//  Created by Theo Sementa on 06/06/2026.
//

import Foundation

struct FinancialGoalDetailsReducer {

    func reduce(state: FinancialGoalDetailsState, result: FinancialGoalDetailsResult) -> FinancialGoalDetailsState {
        var newState = state

        switch result {
        case .bootstrapped(let goalId):
            newState.goalId = goalId

        case .monthlyDataPointsLoaded(let points):
            newState.monthlyDataPoints = points
        }

        return newState
    }

}
