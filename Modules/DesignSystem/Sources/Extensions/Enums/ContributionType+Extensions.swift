//
//  File.swift
//  DesignSystem
//
//  Created by Theo Sementa on 26/03/2026.
//

import Foundation
import Models
import SwiftUI

public extension ContributionType {
    
    var icon: ImageType {
        switch self {
        case .add:
            return .iconHandCoins
        case .remove:
            return .iconWithdrawal
        }
    }
    
    var name: String { // TODO: TBL
        switch self {
        case .add:
            return "Ajout"
        case .remove:
            return "Retrait"
        }
    }
    
    var color: Color {
        switch self {
        case .add:
            return .Success.s500
        case .remove:
            return .Error.e500
        }
    }
    
    var bgColor: Color {
        switch self {
        case .add:
            return .Success.s100
        case .remove:
            return .Error.e100
        }
    }
    
}
