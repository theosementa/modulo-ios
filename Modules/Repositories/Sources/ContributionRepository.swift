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
    
    public func fetchAll(for goalId: UUID) -> [ContributionEntity] {
        let goalRepository: FinancialGoalRepository = .init()
        
        do {
            let goal = goalRepository.fetchOneByEntityId(goalId)
            
            let predicate = #Predicate<ContributionEntity> {
                $0.financialGoal.id == goalId
            }
            
            return try context.fetch(.init(predicate: predicate))
        } catch {
            return []
        }
    }
    
}
