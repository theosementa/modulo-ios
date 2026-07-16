//
//  AddFinancialGoalFlowStore.swift
//  Features
//
//  Created by Theo Sementa on 06/06/2026.
//

import Foundation

protocol AddFinancialGoalFlowStore {
    var state: AddFinancialGoalFlowState { get }
    var sideEffects: AsyncStream<AddFinancialGoalFlowSideEffect> { get }
    func send(_ intent: AddFinancialGoalFlowIntent)
}
