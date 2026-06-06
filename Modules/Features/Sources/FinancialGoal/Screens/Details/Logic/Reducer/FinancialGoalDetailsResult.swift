//
//  FinancialGoalDetailsResult.swift
//  Features
//
//  Created by Theo Sementa on 06/06/2026.
//

import Foundation
import Models

enum FinancialGoalDetailsResult {
    case bootstrapped(goalId: String)
    case monthlyDataPointsLoaded([ContributionMonthlyDataPoint])
}
