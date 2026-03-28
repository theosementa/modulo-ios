//
//  File.swift
//  Stores
//
//  Created by Theo Sementa on 28/03/2026.
//

import Foundation
import Repositories
import Models

@Observable
public final class DefaultContributionStore: ContributionStore {
    
    @MainActor public static let shared = DefaultContributionStore()
    
    public var repository: ContributionRepository
    public var contributions: [ContributionDomain] = []
    
    public init(repository: ContributionRepository = .init()) {
        self.repository = repository
    }
    
}
