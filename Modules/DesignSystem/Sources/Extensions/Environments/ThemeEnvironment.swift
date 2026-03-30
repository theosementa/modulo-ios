//
//  File.swift
//  DesignSystem
//
//  Created by Theo Sementa on 30/03/2026.
//

import Foundation
import Models
import Core
import SwiftUI

public extension EnvironmentValues {
    @Entry var theme: ThemeColorType = ThemeColorType(rawValue: UserDefaultManager.shared.selectedTheme) ?? .blue
}
