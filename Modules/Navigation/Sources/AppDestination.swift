//
//  File.swift
//  Navigation
//
//  Created by Theo Sementa on 22/02/2026.
//

import Foundation
import NavigationKit

public enum AppDestination: AppDestinationProtocol {
    case financialGoal(FinancialGoalDestination)
}

extension AppDestination: RecursiveDestination {
    
    public var unwrapped: AnyHashable {
        switch self {
        case .financialGoal(let financialGoalDestination):
            return financialGoalDestination
        }
    }
    
}
