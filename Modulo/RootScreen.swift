//
//  RootScreen.swift
//  Modulo
//
//  Created by Theo Sementa on 22/03/2026.
//

import SwiftUI
import Navigation
import FinancialGoal

struct RootScreen: View {
    
    // MARK: Constants
    private let router: Router<AppDestination> = .init()
    private let routerManager: AppRouterManager = .shared
    
    // MARK: - View
    var body: some View {
        NavigationStackView(
            router: router,
            routerManager: routerManager,
            flow: AppFlow.home,
            isTabPage: false
        ) {
            FinancialGoalListScreen()
        }
    }
}

// MARK: - Preview
#Preview {
    RootScreen()
}
