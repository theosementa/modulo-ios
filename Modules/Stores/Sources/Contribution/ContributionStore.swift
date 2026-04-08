//
//  File.swift
//  Stores
//
//  Created by Theo Sementa on 28/03/2026.
//

import Foundation
import Repositories
import Models

@MainActor
public protocol ContributionStore: AnyObject {
    var repository: ContributionRepository { get }
    var financialGoalStore: FinancialGoalStore { get }
    var contributions: [ContributionDomain] { get set }
    
    @discardableResult
    func fetchAll(addToRepo: Bool) -> [ContributionDomain]
}

// MARK: - Public methods
public extension ContributionStore {
    
    func create(contribution: ContributionDomain) {
        guard let goalEntity = financialGoalStore.findOneEntity(by: contribution.goalId) else { return }
        let draftEntity = contribution.toEntity(goal: goalEntity)
        do {
            let entity = try repository.save(draftEntity)
            if let domain = entity?.toDomain() {
                add(domain)
            }
        } catch {
            
        }
    }
    
    func update(contribution: ContributionDomain) {
        guard let uuid = UUID(uuidString: contribution.id) else { return }
        do {
            if let entity = repository.fetchOneByEntityId(uuid) {
                entity.name = contribution.name
                entity.amount = contribution.amount
                entity.date = contribution.date
                entity.type = contribution.type.rawValue
                
                try repository.save(entity)
                replace(contribution)
            }
        } catch {
            
        }
    }
    
    func delete(by id: String) {
        guard let uuid = UUID(uuidString: id) else { return }
        let contributionToDelete = repository.fetchOneByEntityId(uuid)

        if let contributionToDelete {
            do {
                try repository.delete(contributionToDelete)
                self.contributions.removeAll(where: { $0.id == id })
            } catch { }
        }
    }
    
    func findOneBy(_ id: String) -> ContributionDomain? {
        return self.contributions.first(where: { $0.id == id })
    }
    
}

// MARK: - Private methods
private extension ContributionStore {
    
    func add(_ contribution: ContributionDomain) {
        if self.contributions.contains(where: { $0.id == contribution.id }) == false {
            self.contributions.append(contribution)
        }
    }
    
    func replace(_ contribution: ContributionDomain) {
        if let index = self.contributions.firstIndex(where: { $0.id == contribution.id }) {
            self.contributions[index] = contribution
        }
    }
    
}
