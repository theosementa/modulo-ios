//
//  SwiftUIView.swift
//  DesignSystem
//
//  Created by Theo Sementa on 04/04/2026.
//

import SwiftUI
import Models
import Core

public struct OnboardingScreen: View {
    
    public init () { }
    
    // MARK: - View
    public var body: some View {
        VStack(spacing: 48) {
            (Text("onboarding_title_welcome".localized) + Text(" Modulo").foregroundStyle(.blue))
                .font(.Display.largeBold)
                .multilineTextAlignment(.leading)
                .fullWidth(.leading)
            
            VStack(spacing: .large) {
                onboardingRowView(
                    icon: .iconTarget,
                    title: "onboarding_first_section_title".localized,
                    description: "onboarding_first_section_desc".localized
                )
                
                onboardingRowView(
                    icon: .iconHandCoins,
                    title: "onboarding_second_section_title".localized,
                    description: "onboarding_second_section_desc".localized
                )
                
                onboardingRowView(
                    icon: .iconCoins,
                    title: "onboarding_third_section_title".localized,
                    description: "onboarding_third_section_desc".localized
                )
            }
            .fullSize(.top)
            
            ActionButtonView(text: "onboarding_action_button".localized) {
                UserDefaultManager.shared.isOnboardingNeedToBePresented = false
            }
        }
        .padding(.large)
    }
}

// MARK: - Subviews
fileprivate extension OnboardingScreen {
    
    @ViewBuilder
    func onboardingRowView(icon: ImageType, title: String, description: String) -> some View {
        HStack(spacing: .large) {
            IconView(icon, size: 48, color: .blue)
            
            VStack(alignment: .leading, spacing: .tiny) {
                Text(title)
                    .font(.Body.largeMedium)
                    .fullWidth(.leading)
                    .multilineTextAlignment(.leading)
                
                Text(description)
                    .font(.Body.mediumRegular)
                    .fullWidth(.leading)
                    .multilineTextAlignment(.leading)
            }
        }
    }
    
}

// MARK: - Preview
#Preview {
    OnboardingScreen()
}
