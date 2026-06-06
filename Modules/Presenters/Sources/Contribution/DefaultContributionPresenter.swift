//
//  DefaultContributionPresenter.swift
//  Presenters
//
//  Created by Theo Sementa on 28/03/2026.
//

import Foundation
import DataSources
import Utilities

public final class DefaultContributionPresenter: ContributionPresenter {
    @MainActor
    public static let shared: ContributionPresenter = AppConfiguration.isMockEnv ? MockContributionPresenter() : DefaultContributionPresenter()

    public var dataSource: ContributionDataSource

    public init(dataSource: ContributionDataSource = DefaultContributionDataSource.shared) {
        self.dataSource = dataSource
    }
}
