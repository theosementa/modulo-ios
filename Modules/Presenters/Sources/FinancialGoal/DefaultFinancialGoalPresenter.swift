//
//  DefaultFinancialGoalPresenter.swift
//  Presenters
//
//  Created by Theo Sementa on 25/03/2026.
//

import Foundation
import DataSources
import Utilities

public final class DefaultFinancialGoalPresenter: FinancialGoalPresenter {
    @MainActor
    public static let shared: FinancialGoalPresenter = AppConfiguration.isMockEnv ? MockFinancialGoalPresenter() : DefaultFinancialGoalPresenter()

    public var dataSource: FinancialGoalDataSource

    public init(dataSource: FinancialGoalDataSource = DefaultFinancialGoalDataSource.shared) {
        self.dataSource = dataSource
    }
}
