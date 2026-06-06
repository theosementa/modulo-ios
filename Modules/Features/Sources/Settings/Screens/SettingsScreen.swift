//
//  SwiftUIView.swift
//  Features
//
//  Created by Theo Sementa on 30/03/2026.
//

import SwiftUI
import DesignSystem
import Navigation
import Core
import Models
import DataSources
import ToastBannerKit

struct SettingsScreen: View {

    // MARK: Environments
    @Environment(\.openURL) private var openURL
    @Environment(Router<AppDestination>.self) private var router

    // MARK: States
    @State private var userDefaultManager = UserDefaultManager.shared
    @State private var isAlertDataPresented: Bool = false

    // MARK: Constants
    private let appVersion: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"

    // MARK: Computed
    private var selectedTheme: ThemeColorType {
        ThemeColorType(rawValue: userDefaultManager.selectedTheme) ?? .blue
    }

    // MARK: - View
    var body: some View {
        VStack(spacing: .zero) {
            NavigationBarView(style: .push(title: "generic_settings".localized))

            ScrollView {
                VStack(spacing: .medium) {
                    preferencesSectionView
                    actionsSectionView
                    dangerSectionView
                    legalSectionView
                    footerView
                }
            }
            .contentMargins(.all, .standard, for: .scrollContent)
        }
        .navigationBarBackButtonHidden(true)
        .background(Color.Background.bg50)
        .confirmationAlert(.deleteAllData, isPresented: $isAlertDataPresented) {
            deleteAll()
        }
    }
}

// MARK: - Subviews
fileprivate extension SettingsScreen {

    var preferencesSectionView: some View {
        VStack(spacing: .standard) {
            SettingsRowView(
                icon: .iconVibration,
                text: "setting_haptic_feedback".localized,
                style: .casual
            ) {
                @Bindable var userDefaultManager = userDefaultManager
                Toggle("", isOn: $userDefaultManager.isHapticFeebackEnabled)
                    .labelsHidden()
                    .tint(selectedTheme.color)
            }

            DividerView(color: .Background.bg200)

            SettingsRowView(
                icon: .iconColors,
                text: "setting_theme".localized,
                style: .casual
            ) {
                Menu {
                    ForEach(ThemeColorType.allCases, id: \.self) { theme in
                        Button {
                            userDefaultManager.selectedTheme = theme.rawValue
                        } label: {
                            Label(theme.name, systemImage: "square.fill")
                                .tint(theme.color)
                        }
                    }
                } label: {
                    Text(selectedTheme.name)
                        .font(.Body.largeMedium, color: selectedTheme.color)
                }
            }
        }
        .padding(.standard)
        .background(Color.Background.bg100, in: .rect(cornerRadius: .mediumLarge, style: .continuous))
    }

    var actionsSectionView: some View {
        VStack(spacing: .standard) {
            Button {
                if let url = URL(string: AppConstant.Link.writeReview) { openURL(url) }
            } label: {
                SettingsRowView(
                    icon: .iconStar,
                    text: "setting_write_review".localized,
                    style: .casual
                )
            }

            DividerView(color: .Background.bg200)

//            Button {
//
//            } label: {
//                SettingsRowView(
//                    icon: .iconSend,
//                    text: "setting_share_app".localized,
//                    style: .casual
//                )
//            }
//
//            DividerView(color: .Background.bg200)

            Button {
                if let url = URL(string: AppConstant.Link.contactEmail) { openURL(url) }
            } label: {
                SettingsRowView(
                    icon: .iconMessage,
                    text: "setting_contact_us".localized,
                    style: .casual
                )
            }
        }
        .padding(.standard)
        .background(Color.Background.bg100, in: .rect(cornerRadius: .mediumLarge, style: .continuous))
    }

    var dangerSectionView: some View {
        VStack(spacing: .zero) {
            Button {
                isAlertDataPresented = true
            } label: {
                SettingsRowView(
                    icon: .iconTrash,
                    text: "setting_delete_data".localized,
                    style: .destructive
                ) {
                    EmptyView()
                }
            }
        }
        .padding(.standard)
        .background(Color.Background.bg100, in: .rect(cornerRadius: .mediumLarge, style: .continuous))
    }

    var legalSectionView: some View {
        VStack(spacing: .standard) {
            Button { openPrivacyPolicy() } label: {
                SettingsRowView(
                    icon: .iconLock,
                    text: "setting_privacy_policy".localized,
                    style: .casual
                )
            }

            DividerView(color: .Background.bg200)

            Button { openConditionOfUse() } label: {
                SettingsRowView(
                    icon: .iconFile,
                    text: "setting_condition_of_use".localized,
                    style: .casual
                )
            }
        }
        .padding(.standard)
        .background(Color.Background.bg100, in: .rect(cornerRadius: .mediumLarge, style: .continuous))
    }

    var footerView: some View {
        VStack(spacing: .zero) {
            Text("v\(appVersion)")
                .font(.Body.mediumMedium)
            Text("setting_made_by".localized)
                .font(.Label.largeMedium)
        }
        .padding(.top, .small)
    }

}

// MARK: - Actions
fileprivate extension SettingsScreen {

    func deleteAll() {
        DefaultFinancialGoalDataSource.shared.deleteAll()
        ToastBannerService.shared.send(.successDeleteAllData)
    }

    func openPrivacyPolicy() {
        guard let url = URL(string: AppConstant.Link.privacyPolicy) else { return }
        router.present(route: .fullScreenCover, .shared(.sfSafari(url: url)))
    }

    func openConditionOfUse() {
        guard let url = URL(string: AppConstant.Link.conditionsOfUse) else { return }
        router.present(route: .fullScreenCover, .shared(.sfSafari(url: url)))
    }

}

// MARK: - Preview
#Preview {
    SettingsScreen()
}
