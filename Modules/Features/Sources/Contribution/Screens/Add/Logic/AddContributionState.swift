//
//  AddContributionState.swift
//  Features
//
//  Created by Theo Sementa on 06/06/2026.
//

import Foundation
import Models

struct AddContributionState {

    enum ScreenState: Equatable {
        case idle
        case loading
        case error(String)
    }

    var screenState: ScreenState = .idle

    var goalId: String = ""
    var contributionId: String? = nil
    var name: String = ""
    var amount: String = "0"
    var date: Date? = .now
    var type: ContributionType = .add

    var isAlertLeavePresented: Bool = false
}

extension AddContributionState {

    var errorMessage: String? {
        guard case .error(let error) = screenState else { return nil }
        return error
    }

    var isModelInCreation: Bool {
        amount.toDouble() != 0 || name.isReallyEmpty == false
    }

    var isEditing: Bool { contributionId != nil }

}
