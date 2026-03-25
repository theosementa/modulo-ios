//
//  File.swift
//  Providers
//
//  Created by Theo Sementa on 25/03/2026.
//

import Foundation
import Stores
import Models

public enum FinancialGoalScope {
    case maxAmount
}

@MainActor
public protocol FinancialGoalProvider {
    var store: FinancialGoalStore { get }
}

public extension FinancialGoalProvider {
    
    func financialGoals(by scope: FinancialGoalScope) -> [FinancialGoalDomain] {
        switch scope {
        case .maxAmount:
            return store.financialGoals
        }
    }
    
}
