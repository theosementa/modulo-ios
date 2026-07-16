//
//  File.swift
//  DesignSystem
//
//  Created by Theo Sementa on 28/03/2026.
//

import Foundation
import Models
import Navigation

public extension CustomEmptyStyle {
    
    var icon: ImageType {
        switch self {
        case .noGoals:
            return .iconTarget
        }
    }
    
    var title: String {
        switch self {
        case .noGoals:
            return "empty_title_no_targets".localized
        }
    }
    
    var description: String {
        switch self {
        case .noGoals:
            return "empty_message_no_targets".localized
        }
    }
    
    var buttonTitle: String? {
        switch self {
        case .noGoals:
            return "empty_button_title_no_targets".localized
        }
    }
    
    var buttonIcon: ImageType? {
        switch self {
        case .noGoals:
            return .iconPlus
        }
    }
    
    @MainActor func action(router: Router<AppDestination>) {
        switch self {
        case .noGoals:
            router.present(route: .fullScreenCover, .financialGoal(.addFlow))
        }
    }
    
}
