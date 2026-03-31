//
//  File.swift
//  Features
//
//  Created by Theo Sementa on 25/03/2026.
//

import Foundation
import Navigation
import SwiftUI

public extension NavigationRegistry {
    
    @MainActor
    func registerFinancialGoalsRoutes() {
        self.register(FinancialGoalDestination.self) { destination in
            switch destination {
            case .list:
                return AnyView(FinancialGoalListScreen())
            case .create:
                return AnyView(AddFinancialGoalScreen())
            case let .update(id):
                return AnyView(AddFinancialGoalScreen(goalId: id))
            case let .details(id):
                return AnyView(FinancialGoalDetailsScreen(id: id))
            }
        }
    }
    
}
