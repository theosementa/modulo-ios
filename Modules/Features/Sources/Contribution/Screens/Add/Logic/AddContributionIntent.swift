//
//  AddContributionIntent.swift
//  Features
//
//  Created by Theo Sementa on 06/06/2026.
//

import Foundation
import Models

enum AddContributionIntent {
    case bootstrap(goalId: String, contributionId: String?)

    case nameChanged(String)
    case amountChanged(String)
    case dateChanged(Date?)
    case typeChanged(ContributionType)

    case dismissAttempted
    case dismissConfirmed
    case alertLeavePresented(Bool)

    case save
    case update
}
