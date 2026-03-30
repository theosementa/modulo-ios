//
//  File.swift
//  Features
//
//  Created by Theo Sementa on 30/03/2026.
//

import Foundation
import Navigation
import SwiftUI

public extension NavigationRegistry {
    
    @MainActor
    func registerSettingsRoutes() {
        self.register(SettingsDestination.self) { destination in
            switch destination {
            case .list:
                AnyView(SettingsScreen())
            }
        }
    }
    
}
