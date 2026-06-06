//
//  FinancialGoalDetailsStore.swift
//  Features
//
//  Created by Theo Sementa on 06/06/2026.
//

import Foundation
import Models

protocol FinancialGoalDetailsStore {
    var state: FinancialGoalDetailsState { get }
    var sideEffects: AsyncStream<FinancialGoalDetailsSideEffect> { get }
    var detailledGoal: FinancialGoalDetailedDomain? { get }
    var contributions: [ContributionDomain] { get }
    func send(_ intent: FinancialGoalDetailsIntent)
}
