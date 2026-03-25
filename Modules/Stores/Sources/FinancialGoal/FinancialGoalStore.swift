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
}

public extension FinancialGoalStore {
    
    func fetchAll() {
        do {
            let entities = try repository.fetchAll()
            self.financialGoals = entities.map { $0.toDomain() }
        } catch {
            
        }
    }
    
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
            } catch {
                
            }
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
