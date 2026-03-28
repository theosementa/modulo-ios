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
    var contributions: [ContributionDomain] { get set }
}

// MARK: - Public methods
public extension ContributionStore {
    
    func fetchAll() {
        guard let goalId = DefaultFinancialGoalStore.shared.currentGoalId,
              let uuid = UUID(uuidString: goalId)
        else { return }
        
        let entities = repository.fetchAll(for: uuid)
        self.contributions = entities.map { $0.toDomain() }
    }
    
    func create(contribution: ContributionDomain, in goal: FinancialGoalEntity) {
        let draftEntity = contribution.toEntity(goal: goal)
        do {
            let entity = try repository.save(draftEntity)
            if let domain = entity?.toDomain() {
                add(domain)
            }
        } catch {
            
        }
    }
    
}

// MARK: - Private methods
private extension ContributionStore {
    
    func add(_ contribution: ContributionDomain) {
        if self.contributions.contains(where: { $0.id == contribution.id }) == false {
            self.contributions.append(contribution)
        }
    }
    
}
