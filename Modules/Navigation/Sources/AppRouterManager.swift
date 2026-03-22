//
//  AppRouterManager.swift
//  Navigation
//
//  Created by Theo Sementa on 22/02/2026.
//

import Foundation
import NavigationKit

@MainActor @Observable
public final class AppRouterManager: RouterManager<AppFlow, AppDestination> {
    public static let shared: AppRouterManager = .init()
    
    init() {
        super.init(selectedFlow: .home)
    }
    
}
