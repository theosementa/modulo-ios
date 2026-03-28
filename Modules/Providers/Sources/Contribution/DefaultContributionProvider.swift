//
//  File.swift
//  Providers
//
//  Created by Theo Sementa on 28/03/2026.
//

import Foundation
import Stores

public final class DefaultContributionProvider: ContributionProvider {
    @MainActor public static let shared = DefaultContributionProvider()
    
    public var store: ContributionStore
    
    public init(store: ContributionStore = DefaultContributionStore.shared) {
        self.store = store
    }
}
