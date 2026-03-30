//
//  ThemeColor.swift
//  Models
//
//  Created by Theo Sementa on 30/03/2026.
//

import Foundation

public enum ThemeColorType: String, CaseIterable {
    case green, blue, purple, pink, red
    
    public var name: String {
        switch self {
        case .green: return "theme_green".localized
        case .blue: return "theme_blue".localized
        case .purple: return "theme_purple".localized
        case .pink: return "theme_pink".localized
        case .red: return "theme_red".localized
        }
    }
}
