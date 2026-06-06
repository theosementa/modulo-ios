//
//  FinancialGoalDetailsState.swift
//  Features
//
//  Created by Theo Sementa on 06/06/2026.
//

import Foundation
import Models

struct FinancialGoalDetailsState {

    enum ScreenState: Equatable {
        case idle
        case loading
        case error(String)
    }

    var screenState: ScreenState = .idle
    var goalId: String = ""
    var monthlyDataPoints: [ContributionMonthlyDataPoint] = []
}

extension FinancialGoalDetailsState {
    var errorMessage: String? {
        guard case .error(let error) = screenState else { return nil }
        return error
    }

    var isChartDisplayed: Bool { !monthlyDataPoints.isEmpty }
}
