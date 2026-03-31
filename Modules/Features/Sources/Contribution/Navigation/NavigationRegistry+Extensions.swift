//
//  File.swift
//  Features
//
//  Created by Theo Sementa on 26/03/2026.
//

import Foundation
import Navigation
import SwiftUI

public extension NavigationRegistry {
    
    @MainActor
    func registerContributionRoutes() {
        self.register(ContributionDestination.self) { destination in
            switch destination {
            case let .create(goalId):
                AnyView(AddContributionScreen(goalId: goalId))
            case let .update(goalId, contributionId):
                AnyView(AddContributionScreen(goalId: goalId, contributionId: contributionId))
            }
        }
    }
    
}
