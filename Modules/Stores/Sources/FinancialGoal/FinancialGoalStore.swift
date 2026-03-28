//
//  File.swift
//  Stores
//
//  Created by Theo Sementa on 25/03/2026.
//

import Foundation
import Repositories
import Models

@MainActor
public protocol FinancialGoalStore: AnyObject {
    var repository: FinancialGoalRepository { get }
    var financialGoals: [FinancialGoalDomain] { get set }
    
    func fetchAll() -> Void
    func findOneDetailed(by id: String) -> FinancialGoalDetailedDomain?
}

public extension FinancialGoalStore {
    
    func findOne(by id: String) -> FinancialGoalDomain? {
        return financialGoals
            .first(where: { $0.id == id })
    }
    
    func create(goal: FinancialGoalDomain) {
        let draftEntity = goal.toEntity()
        do {
            let entity = try repository.save(draftEntity)
            if let domain = entity?.toDomain() {
                add(domain)
            }
        } catch {
            
        }
    }
    
    func delete(by id: String) {
        guard let uuid = UUID(uuidString: id) else { return }
        let goalToDelete = repository.fetchOneByEntityId(uuid)

        if let goalToDelete {
            do {
                try repository.delete(goalToDelete)
                self.financialGoals.removeAll(where: { $0.id == id })
            } catch { }
        }
    }

    func fetchContributions(for goalId: String, offset: Int, limit: Int) -> [ContributionDomain] {
        guard let uuid = UUID(uuidString: goalId) else { return [] }
        return repository.fetchContributions(for: uuid, offset: offset, limit: limit).map { $0.toDomain() }
    }

    func fetchMonthlyDataPoints(for goalId: String) -> [ContributionMonthlyDataPoint] {
        guard let uuid = UUID(uuidString: goalId) else { return [] }
        return repository.fetchMonthlyDataPoints(for: uuid)
    }

    func addContribution(to goalId: String, name: String?, amount: Double, type: ContributionType, date: Date) {
        guard let uuid = UUID(uuidString: goalId),
              let entity = repository.fetchOneByEntityId(uuid) else { return }

        let contribution = ContributionEntity(
            name: name,
            amount: amount,
            type: type,
            date: date,
            financialGoal: entity
        )
        entity.contributions.append(contribution)
        try? repository.saveContext()

        if let index = financialGoals.firstIndex(where: { $0.id == goalId }) {
            financialGoals[index] = entity.toDomain()
        }
    }

}

private extension FinancialGoalStore {
    
    func add(_ goal: FinancialGoalDomain) {
        if financialGoals.contains(where: { $0.id == goal.id }) == false {
            financialGoals.append(goal)
        }
    }
    
}
