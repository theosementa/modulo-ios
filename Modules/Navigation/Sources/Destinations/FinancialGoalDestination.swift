//
//  File.swift
//  Navigation
//
//  Created by Theo Sementa on 22/03/2026.
//

import Foundation
import NavigationKit

public enum FinancialGoalDestination: DestinationItem {
    case list
    case add
    case update(id: String)
}
