//
//  AddFinancialGoalError.swift
//  Features
//
//  Created by Theo Sementa on 25/03/2026.
//

import Foundation

enum AddFinancialGoalError: Error {
    case missingName
    case missingAmount
    case persistenceFailed
}

extension AddFinancialGoalError {

    var description: String {
        switch self {
        case .missingName:
            return "toast_banner_name_mandatory".localized
        case .missingAmount:
            return "toast_banner_amount_mandatory".localized
        case .persistenceFailed:
            return "generic_error".localized
        }
    }

}
