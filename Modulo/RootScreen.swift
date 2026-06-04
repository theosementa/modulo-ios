//
//  RootScreen.swift
//  Modulo
//
//  Created by Theo Sementa on 22/03/2026.
//

import SwiftUI
import Navigation
import Core
import FinancialGoal
import ToastBannerKit
import DesignSystem

struct RootScreen: View {
    
    // MARK: States
    @State private var toastBannerService: ToastBannerService = .shared
    @State private var userDefaultManager: UserDefaultManager = .shared
    
    // MARK: - View
    var body: some View {
        NavigationStackView(
            routerManager: AppRouterManager.shared,
            flow: AppFlow.home,
            isTabPage: true
        ) {
            Group {
                if userDefaultManager.isOnboardingNeedToBePresented {
                    OnboardingScreen()
                } else {
                    FinancialGoalListScreen()
                }
            }
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
