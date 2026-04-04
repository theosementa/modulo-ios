//
//  UserDefaultManager.swift
//  Core
//
//  Created by Theo Sementa on 30/03/2026.
//

import Foundation
import SwiftUI
import Models

@Observable
public final class UserDefaultManager: @unchecked Sendable {
    public static let shared = UserDefaultManager()

    @ObservationIgnored
    @ObservableUserDefault("isOnboardingNeedToBePresented")
    public var isOnboardingNeedToBePresented: Bool = true

    // MARK: - Preferences
    @ObservationIgnored
    @ObservableUserDefault("isHapticFeebackEnabled")
    public var isHapticFeebackEnabled: Bool = true

    @ObservationIgnored
    @ObservableUserDefault("selectedTheme")
    public var selectedTheme: String = ThemeColorType.blue.rawValue
    
}
