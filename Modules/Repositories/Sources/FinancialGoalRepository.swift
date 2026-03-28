//
//  File.swift
//  Repositories
//
//  Created by Theo Sementa on 25/03/2026.
//

import Foundation
import Models
import Persistence
import SwiftData

public final class FinancialGoalRepository: GenericRepository<FinancialGoalEntity> {

    public func fetchOneByEntityId(_ id: UUID) -> FinancialGoalEntity? {
        let predicate = #Predicate<FinancialGoalEntity> { $0.id == id }
        var descriptor = FetchDescriptor<FinancialGoalEntity>(predicate: predicate)
        descriptor.fetchLimit = 1
        return try? context.fetch(descriptor).first
    }

    public func fetchContributions(for goalId: UUID, offset: Int, limit: Int) -> [ContributionEntity] {
        let predicate = #Predicate<ContributionEntity> { $0.financialGoal.id == goalId }
        var descriptor = FetchDescriptor<ContributionEntity>(
            predicate: predicate,
            sortBy: [SortDescriptor(\.date, order: .reverse)]
        )
        descriptor.fetchOffset = offset
        descriptor.fetchLimit = limit
        return (try? context.fetch(descriptor)) ?? []
    }
    
    public func fetchMonthlyDataPoints(for goalId: UUID) -> [ContributionMonthlyDataPoint] {
        let calendar = Calendar.current

        let predicate = #Predicate<ContributionEntity> { $0.financialGoal.id == goalId }
        var oldestDescriptor = FetchDescriptor<ContributionEntity>(
            predicate: predicate,
            sortBy: [SortDescriptor(\.date, order: .forward)]
        )
        oldestDescriptor.fetchLimit = 1

        var newestDescriptor = FetchDescriptor<ContributionEntity>(
            predicate: predicate,
            sortBy: [SortDescriptor(\.date, order: .reverse)]
        )
        newestDescriptor.fetchLimit = 1

        guard
            let oldestDate = (try? context.fetch(oldestDescriptor))?.first?.date,
            let newestDate = (try? context.fetch(newestDescriptor))?.first?.date,
            let startOfFirstMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: oldestDate)),
            let startOfLastMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: newestDate))
        else { return [] }

        var result: [ContributionMonthlyDataPoint] = []
        var cursor = startOfFirstMonth

        while cursor <= startOfLastMonth {
            let monthStart = cursor
            let monthEnd = calendar.date(byAdding: .month, value: 1, to: cursor) ?? cursor

            let predicate = #Predicate<ContributionEntity> {
                $0.financialGoal.id == goalId &&
                $0.date >= monthStart &&
                $0.date < monthEnd
            }
            let contributions = (try? context.fetch(FetchDescriptor(predicate: predicate))) ?? []
            let net = contributions.reduce(0.0) { $0 + ($1.type == .add ? $1.amount : -$1.amount) }

            result.append(ContributionMonthlyDataPoint(
                id: monthStart.formatted(.dateTime.year().month()),
                month: monthStart,
                monthLabel: monthStart.formatted(.dateTime.month(.abbreviated).year(.twoDigits)),
                netAmount: net
            ))

            cursor = monthEnd
        }

        return result
    }

}
