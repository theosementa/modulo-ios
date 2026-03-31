//
//  File.swift
//  DesignSystem
//
//  Created by Theo Sementa on 31/03/2026.
//

import Foundation
import Models

public extension ConfirmationAlertType {
    
    var title: String {
        switch self {
        case .leaveWithoutSaving:
            return "confirmation_leave_form_title".localized
        case .deletion, .deleteAllData:
            return "confirmation_deletion_title".localized
        }
    }
    
    var message: String {
        switch self {
        case .leaveWithoutSaving:
            return "confirmation_leave_form_message".localized
        case .deletion:
            return "confirmation_deletion_message".localized
        case .deleteAllData:
            return "confirmation_delete_all_data_message".localized
        }
    }
    
    var cancelButton: String {
        return "generic_cancel".localized
    }
    
    var actionButton: String {
        switch self {
        case .leaveWithoutSaving:
            return "confirmation_leave_form_destructive_button".localized
        case .deletion, .deleteAllData:
            return "generic_delete".localized
        }
    }
    
}
