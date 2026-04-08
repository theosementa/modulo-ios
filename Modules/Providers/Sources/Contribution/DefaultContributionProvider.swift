//
//  File.swift
//  Providers
//
//  Created by Theo Sementa on 28/03/2026.
//

import Foundation
import Stores
import Utilities

public final class DefaultContributionProvider: ContributionProvider {
    @MainActor
    public static let shared: ContributionProvider = AppConfiguration.isMockEnv ? MockContributionProvider() : DefaultContributionProvider()
    
    public var store: ContributionStore
    
    public init(store: ContributionStore = DefaultContributionStore.shared) {
        self.store = store
    }
}
