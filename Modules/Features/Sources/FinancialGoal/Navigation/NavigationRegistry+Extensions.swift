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
                FinancialGoalListScreen()
            case .create:
                AddFinancialGoalScreen()
            case let .update(id):
                AddFinancialGoalScreen(goalId: id)
            case let .details(id):
                FinancialGoalDetailsScreen(id: id)
            case .addFlow:
                AddFinancialGoalFlowScreen()
            }
        }
    }
    
}
