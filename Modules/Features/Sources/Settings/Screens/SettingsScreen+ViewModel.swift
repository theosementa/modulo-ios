//
//  File.swift
//  Features
//
//  Created by Theo Sementa on 30/03/2026.
//

import Foundation
import Core

extension SettingsScreen {
    
    @Observable
    final class ViewModel {
        
        // MARK: States
        var selectedTheme: ThemeColor = .blue
        
        // MARK: Constants
        let userDefaultManager: UserDefaultManager
        
        // MARK: Init
        init(
            userDefaultManager: UserDefaultManager = .shared
        ) {
            self.userDefaultManager = userDefaultManager
            selectedTheme = ThemeColor(rawValue: userDefaultManager.selectedTheme) ?? .blue
        }
        
    }
    
}
