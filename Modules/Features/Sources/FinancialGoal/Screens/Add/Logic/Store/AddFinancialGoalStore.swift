//
//  AddFinancialGoalStore.swift
//  Features
//
//  Created by Theo Sementa on 25/03/2026.
//

import Foundation

protocol AddFinancialGoalStore {
    var state: AddFinancialGoalState { get }
    var sideEffects: AsyncStream<AddFinancialGoalSideEffect> { get }
    func send(_ intent: AddFinancialGoalIntent)
}
