//
//  MockFinancialGoalPresenter.swift
//  Presenters
//
//  Created by Theo Sementa on 22/03/2026.
//

import Foundation
import Models
import DataSources

public final class MockFinancialGoalPresenter: FinancialGoalPresenter {
    @MainActor public static let shared = MockFinancialGoalPresenter()

    public var dataSource: FinancialGoalDataSource

    public init(dataSource: FinancialGoalDataSource = MockFinancialGoalDataSource.shared) {
        self.dataSource = dataSource
    }
}
