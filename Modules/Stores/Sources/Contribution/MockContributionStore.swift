//
//  MockContributionStore.swift
//  Stores
//
//  Created by Theo Sementa on 03/04/2026.
//

import Foundation
import Models
import Repositories

@Observable
public final class MockContributionStore: ContributionStore {

    @MainActor public static let shared = MockContributionStore()

    public var repository: ContributionRepository = .init()
    public var contributions: [ContributionDomain] = []

    public init(goalId: String = "mock-1") {
        self.contributions = ContributionDomain.mocks(for: goalId)
    }

}

extension MockContributionStore {

    public func fetchAll(addToRepo: Bool = true) -> [ContributionDomain] {
        contributions
    }

    public func create(contribution: ContributionDomain) {
        contributions.append(contribution)
    }

    public func update(contribution: ContributionDomain) {
        guard let index = contributions.firstIndex(where: { $0.id == contribution.id }) else { return }
        contributions[index] = contribution
    }

    public func delete(by id: String) {
        contributions.removeAll(where: { $0.id == id })
    }

    public func findOneBy(_ id: String) -> ContributionDomain? {
        contributions.first(where: { $0.id == id })
    }

}
