//
//  File.swift
//  Navigation
//
//  Created by Theo Sementa on 22/02/2026.
//

import Foundation
import PharosNav

@RecursiveDestination
public enum AppDestination: @MainActor AppDestinationProtocol {
    case shared(SharedDestination)
    case financialGoal(FinancialGoalDestination)
    case contribution(ContributionDestination)
    case settings(SettingsDestination)
}
