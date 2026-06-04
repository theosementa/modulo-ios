//
//  File.swift
//  Features
//
//  Created by Theo Sementa on 17/04/2026.
//

import Foundation

struct AddFinancialGoalReducer {
    
    func reduce(state: AddFinancialGoalState, result: AddFinancialGoalResult) -> AddFinancialGoalState {
        var newState = state
        
        switch result {
            
        case .itemCreationStarted:
            newState.isLoading = true
            newState.errorMessage = nil
            
        case .itemCreated:
            newState.isLoading = false
            
        case .itemCreationFailed(let string):
            newState.isLoading = false
            newState.errorMessage = string
            
        }
        
        return newState
    }
    
}
