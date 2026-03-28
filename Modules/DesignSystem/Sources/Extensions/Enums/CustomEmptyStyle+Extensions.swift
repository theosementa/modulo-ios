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
        case .noTargets:
            return .iconTarget
        }
    }
    
    var title: String {
        switch self {
        case .noTargets:
            return "empty_title_no_targets".localized
        }
    }
    
    var description: String {
        switch self {
        case .noTargets:
            return "empty_message_no_targets".localized
        }
    }
    
    var buttonTitle: String? {
        switch self {
        case .noTargets:
            return "empty_button_title_no_targets".localized
        }
    }
    
    var buttonIcon: ImageType? {
        switch self {
        case .noTargets:
            return .iconPlus
        }
    }
    
    func action(router: Router<AppDestination>) {
        switch self {
        case .noTargets:
            router.present(route: .fullScreenCover, .financialGoal(.create))
        }
    }
    
}
