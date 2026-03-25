//
//  File.swift
//  Providers
//
//  Created by Theo Sementa on 25/03/2026.
//

import Foundation
import Stores

public final class DefaultFinancialGoalProvider: FinancialGoalProvider {
    @MainActor public static let shared = DefaultFinancialGoalProvider()
    
    public var store: FinancialGoalStore
    
    public init(store: FinancialGoalStore = DefaultFinancialGoalStore.shared) {
        self.store = store
    }
}
