//
//  ContributionPresenter.swift
//  Presenters
//
//  Created by Theo Sementa on 28/03/2026.
//

import Foundation
import DataSources
import Models

public enum ContributionSort {
    case date
    case amount
}

@MainActor
public protocol ContributionPresenter {
    var dataSource: ContributionDataSource { get }
}

public extension ContributionPresenter {
    func contributions(sortedBy sort: ContributionSort) -> [ContributionDomain] {
        switch sort {
        case .date:
            return dataSource.contributions.sorted { $0.date > $1.date }
        case .amount:
            return dataSource.contributions.sorted { $0.amount > $1.amount }
        }
    }
}
