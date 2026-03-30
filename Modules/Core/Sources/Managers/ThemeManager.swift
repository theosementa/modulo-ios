//
//  ThemeManager.swift
//  Core
//
//  Created by Theo Sementa on 25/03/2026.
//

import SwiftUI

@Observable
public final class ThemeManager {
    @MainActor public static let shared = ThemeManager()
    
    @AppStorage("theme") @ObservationIgnored public var theme: ThemeColor = .blue
    
    public init() { }
}

public enum ThemeColor: String, CaseIterable {
    case green, blue, purple, red
    
    public var name: String {
        switch self {
        case .green: return "theme_green"
        case .blue: return "theme_blue"
        case .purple: return "theme_purple"
        case .red: return "theme_red"
        }
    }
}

public extension EnvironmentValues {
    @Entry var theme: ThemeColor = ThemeColor(rawValue: UserDefaultManager.shared.selectedTheme) ?? .blue
}
