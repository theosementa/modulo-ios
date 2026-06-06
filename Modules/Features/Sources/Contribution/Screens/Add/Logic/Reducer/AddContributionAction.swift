//
//  AddContributionAction.swift
//  Features
//
//  Created by Theo Sementa on 06/06/2026.
//

import Foundation
import Models

enum AddContributionAction {
    case save(goalId: String, name: String, amount: Double, type: ContributionType, date: Date)
    case update(contributionId: String, goalId: String, name: String, amount: Double, type: ContributionType, date: Date)
}
