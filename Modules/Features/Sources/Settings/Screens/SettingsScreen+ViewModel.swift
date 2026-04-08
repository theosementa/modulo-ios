//
//  File.swift
//  Features
//
//  Created by Theo Sementa on 30/03/2026.
//

import Foundation
import Core
import Models
import Stores
import ToastBannerKit

extension SettingsScreen {
    
    @Observable @MainActor
    final class ViewModel: BaseViewModel {
        
        // MARK: States
        var selectedTheme: ThemeColorType = .blue
        var isAlertDataPresented: Bool = false
        
        // MARK: Constants
        let userDefaultManager: UserDefaultManager
        let appVersion: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
        
        // MARK: Init
        init(
            userDefaultManager: UserDefaultManager = .shared
        ) {
            self.userDefaultManager = userDefaultManager
            selectedTheme = ThemeColorType(rawValue: userDefaultManager.selectedTheme) ?? .blue
        }
        
    }
    
}

extension SettingsScreen.ViewModel {
    
    func deleteAll() {
        DefaultFinancialGoalStore.shared.deleteAll()
        ToastBannerService.shared.send(.successDeleteAllData)
    }
    
    func openPrivacyPolicy() {
        if let url = URL(string: AppConstant.Link.privacyPolicy) {
            router?.present(route: .fullScreenCover, .shared(.sfSafari(url: url)))
        }
    }
    
    func openConditionOfUse() {
        if let url = URL(string: AppConstant.Link.conditionsOfUse) {
            router?.present(route: .fullScreenCover, .shared(.sfSafari(url: url)))
        }
    }
    
}
