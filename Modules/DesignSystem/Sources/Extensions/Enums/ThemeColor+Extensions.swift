//
//  File.swift
//  DesignSystem
//
//  Created by Theo Sementa on 25/03/2026.
//

import Foundation
import SwiftUI
import Core

extension ThemeColor {
    
    public var color: Color {
        switch self {
        case .blue: return .blue
        case .green: return .green
        case .purple: return .purple
        case .red: return .red
        }
    }
    
}
