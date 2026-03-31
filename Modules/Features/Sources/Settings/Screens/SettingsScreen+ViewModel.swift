//
//  File.swift
//  Features
//
//  Created by Theo Sementa on 30/03/2026.
//

import Foundation
import Core
import Models
import Stores

extension SettingsScreen {
    
    @Observable
    final class ViewModel {
        
        // MARK: States
        var selectedTheme: ThemeColorType = .blue
        var isAlertDataPresented: Bool = false
        
        // MARK: Constants
        let userDefaultManager: UserDefaultManager
        let appVersion: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
        
        // MARK: Init
        init(
            userDefaultManager: UserDefaultManager = .shared
        ) {
            self.userDefaultManager = userDefaultManager
            selectedTheme = ThemeColorType(rawValue: userDefaultManager.selectedTheme) ?? .blue
        }
        
    }
    
}

extension SettingsScreen.ViewModel {
    
    @MainActor
    func deleteAll() {
        DefaultFinancialGoalStore.shared.deleteAll()
    }
    
}
