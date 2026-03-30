//
//  File.swift
//  Repositories
//
//  Created by Theo Sementa on 28/03/2026.
//

import Foundation
import Models
import Persistence
import SwiftData

public final class ContributionRepository: GenericRepository<ContributionEntity> {
    
    public func fetchOneByEntityId(_ id: UUID) -> ContributionEntity? {
        let predicate = #Predicate<ContributionEntity> { $0.id == id }
        var descriptor = FetchDescriptor<ContributionEntity>(predicate: predicate)
        descriptor.fetchLimit = 1
        return try? context.fetch(descriptor).first
    }
    
    public func fetchAll(for goalId: UUID) -> [ContributionEntity] {
        do {
            let predicate = #Predicate<ContributionEntity> {
                $0.financialGoal?.id == goalId
            }
            
            return try context.fetch(.init(predicate: predicate))
        } catch {
            return []
        }
    }
    
    public func fetchAllIds(for goalId: UUID) -> [UUID] {
        do {
            let predicate = #Predicate<ContributionEntity> {
                $0.financialGoal?.id == goalId
            }
            var descriptor = FetchDescriptor(predicate: predicate)
            descriptor.propertiesToFetch = [\.id]
            
            return try context.fetch(descriptor).map(\.id)
        } catch {
            return []
        }
    }
    
}
