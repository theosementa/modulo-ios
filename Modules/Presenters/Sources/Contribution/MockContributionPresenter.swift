//
//  MockContributionPresenter.swift
//  Presenters
//
//  Created by Theo Sementa on 08/04/2026.
//

import Foundation
import DataSources

public final class MockContributionPresenter: ContributionPresenter {
    @MainActor public static let shared = MockContributionPresenter()

    public var dataSource: ContributionDataSource

    public init(dataSource: ContributionDataSource = MockContributionDataSource.shared) {
        self.dataSource = dataSource
    }
}
