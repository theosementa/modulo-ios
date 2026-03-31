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

struct SettingsScreen: View {

    // MARK: States
    @State private var viewModel: ViewModel = .init()

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
        .confirmationAlert(.deleteAllData, isPresented: $viewModel.isAlertDataPresented) {
            viewModel.deleteAll()
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
                Toggle("", isOn: viewModel.userDefaultManager.$isHapticFeebackEnabled)
                    .labelsHidden()
                    .tint(viewModel.selectedTheme.color)
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
                            viewModel.selectedTheme = theme
                            viewModel.userDefaultManager.selectedTheme = theme.rawValue
                        } label: {
                            Label(theme.name, systemImage: "square.fill")
                                .tint(theme.color)
                        }
                    }
                } label: {
                    Text(viewModel.selectedTheme.name)
                        .font(.Body.largeMedium, color: viewModel.selectedTheme.color)
                }
            }
        }
        .padding(.standard)
        .background(Color.Background.bg100, in: .rect(cornerRadius: .mediumLarge, style: .continuous))
    }

    var actionsSectionView: some View {
        VStack(spacing: .standard) {
            Button {
                
            } label: {
                SettingsRowView(
                    icon: .iconStar,
                    text: "setting_write_review".localized,
                    style: .casual
                )
            }

            DividerView(color: .Background.bg200)

            SettingsRowView(
                icon: .iconSend,
                text: "setting_share_app".localized,
                style: .casual
            )

            DividerView(color: .Background.bg200)

            SettingsRowView(
                icon: .iconMessage,
                text: "setting_contact_us".localized,
                style: .casual
            )
        }
        .padding(.standard)
        .background(Color.Background.bg100, in: .rect(cornerRadius: .mediumLarge, style: .continuous))
    }

    var dangerSectionView: some View {
        VStack(spacing: .zero) {
            Button {
                viewModel.isAlertDataPresented = true
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
            SettingsRowView(
                icon: .iconLock,
                text: "setting_privacy_policy".localized,
                style: .casual
            )

            DividerView(color: .Background.bg200)

            SettingsRowView(
                icon: .iconFile,
                text: "setting_condition_of_use".localized,
                style: .casual
            )
        }
        .padding(.standard)
        .background(Color.Background.bg100, in: .rect(cornerRadius: .mediumLarge, style: .continuous))
    }

    var footerView: some View {
        VStack(spacing: .zero) {
            Text("v\(viewModel.appVersion)")
                .font(.Body.mediumMedium)
            Text("setting_made_by".localized)
                .font(.Label.largeMedium)
        }
        .padding(.top, .small)
    }

}

// MARK: - Preview
#Preview {
    SettingsScreen()
}
