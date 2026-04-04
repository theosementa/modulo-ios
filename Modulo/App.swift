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

@main
struct ModuloApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    init() {
        NavigationRegistry.shared.registerFinancialGoalsRoutes()
        NavigationRegistry.shared.registerContributionRoutes()
        NavigationRegistry.shared.registerSettingsRoutes()
        NavigationRegistry.shared.registerSharedRoutes()
    }

    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}
