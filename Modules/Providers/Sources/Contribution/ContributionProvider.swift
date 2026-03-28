//
//  File.swift
//  Providers
//
//  Created by Theo Sementa on 28/03/2026.
//

import Foundation
import Stores
import Models

public enum ContributionScope {
    case mostRecent
}

@MainActor
public protocol ContributionProvider {
    var store: ContributionStore { get }
}

public extension ContributionProvider {
    
    func contributions(by scope: ContributionScope) -> [ContributionDomain] {
        switch scope {
        case .mostRecent:
            return store.contributions
                .sorted { $0.date > $1.date }
        }
    }
    
}
