//
//  FinancialGoalPresenter.swift
//  Presenters
//
//  Created by Theo Sementa on 25/03/2026.
//

import Foundation
import DataSources
import Models

public enum FinancialGoalSort {
    case name
    case goalAmount
    case endDate
}

@MainActor
public protocol FinancialGoalPresenter {
    var dataSource: FinancialGoalDataSource { get }
}

public extension FinancialGoalPresenter {
    func goals(sortedBy sort: FinancialGoalSort) -> [FinancialGoalDomain] {
        switch sort {
        case .name:
            return dataSource.financialGoals.sorted { $0.name.localizedCompare($1.name) == .orderedAscending }
        case .goalAmount:
            return dataSource.financialGoals.sorted { $0.goalAmount > $1.goalAmount }
        case .endDate:
            return dataSource.financialGoals.sorted {
                switch ($0.endDate, $1.endDate) {
                case let (l?, r?): return l < r
                case (_?, nil):    return true
                case (nil, _?):    return false
                case (nil, nil):   return false
                }
            }
        }
    }
}
