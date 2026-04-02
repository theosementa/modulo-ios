//
//  RootScreen.swift
//  Modulo
//
//  Created by Theo Sementa on 22/03/2026.
//

import SwiftUI
import Navigation
import FinancialGoal
import ToastBannerKit
import DesignSystem

struct RootScreen: View {
    
    // MARK: States
    @State private var toastBannerService: ToastBannerService = .shared
    
    // MARK: Constants
    private let router: Router<AppDestination> = .init()
    private let routerManager: AppRouterManager = .shared
    
    // MARK: - View
    var body: some View {
        NavigationStackView(
            router: router,
            routerManager: routerManager,
            flow: AppFlow.home
        ) {
            FinancialGoalListScreen()
        }
        .toastBanner(
            item: $toastBannerService.toastBanner,
            config: .init(yOffset: 10, animation: .smooth),
        ) { toastBanner in
            ToastBannerView(banner: toastBanner)
        }
    }
}

// MARK: - Preview
#Preview {
    RootScreen()
}
