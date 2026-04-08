//
//  File.swift
//  Providers
//
//  Created by Theo Sementa on 08/04/2026.
//

import Foundation
import Stores

public final class MockContributionProvider: ContributionProvider {
    @MainActor public static let shared = MockContributionProvider()
    
    public var store: ContributionStore
    
    public init(store: ContributionStore = MockContributionStore.shared) {
        self.store = store
    }
}
