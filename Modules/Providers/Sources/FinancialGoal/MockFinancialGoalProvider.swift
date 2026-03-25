//
//  MockFinancialGoalProvider.swift
//  Providers
//
//  Created by Theo Sementa on 22/03/2026.
//

import Foundation
import Models
import Stores

public final class MockFinancialGoalProvider: FinancialGoalProvider {
    @MainActor public static let shared = MockFinancialGoalProvider()

    public var store: FinancialGoalStore

    public init(store: FinancialGoalStore = MockFinancialGoalStore.shared) {
        self.store = store
    }
}
