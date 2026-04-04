//
//  File.swift
//  DesignSystem
//
//  Created by Theo Sementa on 04/04/2026.
//

import Foundation
import SwiftUI
import Navigation

public extension NavigationRegistry {
    
    @MainActor
    func registerSharedRoutes() {
        self.register(SharedDestination.self) { destination in
            switch destination {
            case .onboarding:
                AnyView(OnboardingScreen())
            }
        }
    }
    
}
