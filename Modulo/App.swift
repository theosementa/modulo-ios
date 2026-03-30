//
//  ModuloApp.swift
//  Modulo
//
//  Created by Theo Sementa on 22/03/2026.
//

import SwiftUI
import Navigation
import FinancialGoal
import Contribution
import Settings

@main
struct ModuloApp: App {
    
    init() {
        NavigationRegistry.shared.registerFinancialGoalsRoutes()
        NavigationRegistry.shared.registerContributionRoutes()
        NavigationRegistry.shared.registerSettingsRoutes()
    }
    
    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}
