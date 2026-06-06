//
//  AddContributionResult.swift
//  Features
//
//  Created by Theo Sementa on 06/06/2026.
//

import Foundation
import Models

enum AddContributionResult {
    case loading
    case submitted
    case failed(String)

    case bootstrapped(goalId: String, contributionId: String?, name: String, amount: String, date: Date?, type: ContributionType)
    case nameChanged(String)
    case amountChanged(String)
    case dateChanged(Date?)
    case typeChanged(ContributionType)
    case alertLeavePresented(Bool)
}
