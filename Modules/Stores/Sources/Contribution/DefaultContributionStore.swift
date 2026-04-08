//
//  File.swift
//  Stores
//
//  Created by Theo Sementa on 28/03/2026.
//

import Foundation
import Repositories
import Models
import Persistence
import Utilities

@Observable
public final class DefaultContributionStore: ContributionStore {

    @MainActor
    public static let shared: ContributionStore = AppConfiguration.environment == .mock ? MockContributionStore() : DefaultContributionStore()

    public var repository: ContributionRepository
    public var financialGoalStore: FinancialGoalStore
    public var contributions: [ContributionDomain] = []

    public init(
        repository: ContributionRepository = .init(),
        financialGoalStore: FinancialGoalStore = DefaultFinancialGoalStore.shared
    ) {
        self.repository = repository
        self.financialGoalStore = financialGoalStore
        observeRemoteChanges()
    }

}

// MARK: - Public methods
public extension DefaultContributionStore {
    
    @discardableResult
    func fetchAll(addToRepo: Bool = true) -> [ContributionDomain] {
        guard let goalId = financialGoalStore.currentGoalId,
              let uuid = UUID(uuidString: goalId)
        else { return [] }
        
        let entities = repository.fetchAll(for: uuid)
        let models = entities.map { $0.toDomain() }
        if addToRepo {
            self.contributions = models
        }
        return models
    }
    
}

// MARK: - Private methods
private extension DefaultContributionStore {

    func syncContributions() {
        guard
            let goalId = DefaultFinancialGoalStore.shared.currentGoalId,
            let uuid = UUID(uuidString: goalId)
        else { return }

        let fresh = repository.fetchAll(for: uuid).map { $0.toDomain() }
        let previousIds = Set(contributions.map(\.id))
        let freshIds = Set(fresh.map(\.id))

        let deletedIds = previousIds.subtracting(freshIds)
        if !deletedIds.isEmpty {
            contributions.removeAll { deletedIds.contains($0.id) }
        }

        let insertedIds = freshIds.subtracting(previousIds)
        let inserted = fresh.filter { insertedIds.contains($0.id) }
        if !inserted.isEmpty {
            contributions.append(contentsOf: inserted)
        }

        let commonIds = previousIds.intersection(freshIds)
        for id in commonIds {
            guard
                let freshContribution = fresh.first(where: { $0.id == id }),
                let index = contributions.firstIndex(where: { $0.id == id })
            else { continue }
            contributions[index] = freshContribution
        }
    }
    
    func observeRemoteChanges() {
        NotificationCenter.default.addObserver(
            forName: SwiftDataContextManager.remoteChangeNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            Task { @MainActor in
                self?.syncContributions()
            }
        }
    }

}
