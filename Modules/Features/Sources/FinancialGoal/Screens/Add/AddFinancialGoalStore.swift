//
//  File.swift
//  Features
//
//  Created by Theo Sementa on 17/04/2026.
//

import Foundation

@Observable @MainActor
final class AddFinancialGoalStore: Sendable {
    
    private(set) var state = AddFinancialGoalState()
    
    private let reducer = AddFinancialGoalReducer()
    
}

extension AddFinancialGoalStore {
    
    func send(_ intent: AddFinancialGoalIntent) {
        switch intent {
        
        case .emojiChanged(let emoji):
            state.emoji = emoji
            
        case .nameChanged(let name):
            state.name = name
            
        case .amountChanged(let amount):
            state.amount = amount
            
        case .startDateChanged(let startDate):
            state.startDate = startDate
            
        case .endDateChanged(let endDate):
            state.endDate = endDate
            
        case .save:
            Task {
                await execute(
                    .save(
                        emoji: state.emoji,
                        name: state.name,
                        amount: state.amount,
                        startDate: state.startDate,
                        endDate: state.endDate
                    )
                )
            }
        }
    }
    
    @MainActor
    private func execute(_ action: AddFinancialGoalAction) async {
        switch action {
        case let .save(emoji, name, amount, startDate, endDate):
            state = reducer.reduce(state: state, result: .itemCreationStarted)
            
            do {
                // Try create
                state = reducer.reduce(state: state, result: .itemCreated)
            } catch {
                state = reducer.reduce(state: state, result: .itemCreationFailed(error.localizedDescription))
            }
            
        case let .update(emoji, name, amount, startDate, endDate):
            state = reducer.reduce(state: state, result: .itemCreationStarted)
            break
        }
    }
    
}
