//
//  UserDefaultManager.swift
//  Core
//
//  Created by Theo Sementa on 30/03/2026.
//

import Foundation
import SwiftUI
import Models

public final class UserDefaultManager: @unchecked Sendable {
    public static let shared = UserDefaultManager()
    
    @AppStorage("isHapticFeebackEnabled")
    public var isHapticFeebackEnabled: Bool = true
    
    @AppStorage("selectedTheme")
    public var selectedTheme: String = ThemeColorType.blue.rawValue
}
