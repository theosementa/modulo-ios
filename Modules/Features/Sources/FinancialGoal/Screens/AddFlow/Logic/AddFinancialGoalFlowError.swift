//
//  AddFinancialGoalFlowError.swift
//  Features
//
//  Created by Theo Sementa on 07/06/2026.
//

import Foundation

enum AddFinancialGoalFlowError: Error {
    case creationFailed
}

extension AddFinancialGoalFlowError {
    var description: String {
        switch self {
        case .creationFailed:
            return "generic_error".localized
        }
    }
}
