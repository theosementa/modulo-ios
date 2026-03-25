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

}
