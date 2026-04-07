//
//  ModuloApp.swift
//  Modulo
//
//  Created by Theo Sementa on 22/03/2026.
//

import SwiftUI
import Navigation
import DesignSystem
import FinancialGoal
import Contribution
import Settings
import Utilities

@main
struct ModuloApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    init() {
        NavigationRegistry.shared.registerFinancialGoalsRoutes()
        NavigationRegistry.shared.registerContributionRoutes()
        NavigationRegistry.shared.registerSettingsRoutes()
        NavigationRegistry.shared.registerSharedRoutes()
        
#if DEV
        AppConfiguration.setEnvironment(.dev)
#elseif MOCK
        AppConfiguration.setEnvironment(.mock)
#else
        AppConfiguration.setEnvironment(.prod)
#endif
        
    }

    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}
