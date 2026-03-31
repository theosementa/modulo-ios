//
//  File.swift
//  Navigation
//
//  Created by Theo Sementa on 26/03/2026.
//

import Foundation

public enum ContributionDestination: DestinationItem {
    case create(goalId: String)
    case update(goalId: String, contributionId: String)
}
