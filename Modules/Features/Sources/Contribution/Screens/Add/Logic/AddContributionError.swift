//
//  AddContributionError.swift
//  Features
//
//  Created by Theo Sementa on 06/06/2026.
//

import Foundation

enum AddContributionError: Error {
    case missingAmount
    case persistenceFailed
}

extension AddContributionError {

    var description: String {
        switch self {
        case .missingAmount:
            return "toast_banner_amount_mandatory".localized
        case .persistenceFailed:
            return "generic_error".localized
        }
    }

}
