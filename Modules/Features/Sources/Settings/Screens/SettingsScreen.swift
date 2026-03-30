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

struct SettingsScreen: View {

    @State private var viewModel: ViewModel = .init()

    // MARK: - View
    var body: some View {
        VStack(spacing: .zero) {
            NavigationBarView(style: .push(title: "generic_settings".localized)) // TODO: TBL

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
    }
}

// MARK: - Subviews
fileprivate extension SettingsScreen {

    var preferencesSectionView: some View {
        VStack(spacing: .standard) {
            SettingsRowView(
                icon: .iconVibration,
                text: "Retour haptique", // TODO: TBL
                style: .casual
            ) {
                Toggle("", isOn: viewModel.userDefaultManager.$isHapticFeebackEnabled)
                    .labelsHidden()
                    .tint(viewModel.selectedTheme.color)
            }

            DividerView(color: .Background.bg200)

            SettingsRowView(
                icon: .iconColors,
                text: "Thème", // TODO: TBL
                style: .casual
            ) {
                Menu {
                    ForEach(ThemeColor.allCases, id: \.self) { theme in
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
                    text: "Rédiger un avis", // TODO: TBL
                    style: .casual
                )
            }

            DividerView(color: .Background.bg200)

            SettingsRowView(
                icon: .iconSend,
                text: "Partager l'app", // TODO: TBL
                style: .casual
            )

            DividerView(color: .Background.bg200)

            SettingsRowView(
                icon: .iconMessage,
                text: "Contactez nous", // TODO: TBL
                style: .casual
            )
        }
        .padding(.standard)
        .background(Color.Background.bg100, in: .rect(cornerRadius: .mediumLarge, style: .continuous))
    }

    var dangerSectionView: some View {
        VStack(spacing: .zero) {
            SettingsRowView(
                icon: .iconTrash,
                text: "Supprimer mes données", // TODO: TBL
                style: .destructive
            ) {
                EmptyView()
            }
        }
        .padding(.standard)
        .background(Color.Background.bg100, in: .rect(cornerRadius: .mediumLarge, style: .continuous))
    }

    var legalSectionView: some View {
        VStack(spacing: .standard) {
            SettingsRowView(
                icon: .iconLock,
                text: "Politique de confidentialité", // TODO: TBL
                style: .casual
            )

            DividerView(color: .Background.bg200)

            SettingsRowView(
                icon: .iconFile,
                text: "Conditions d'utilisation", // TODO: TBL
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
            Text("Made by Theo Sementa")
                .font(.Label.largeMedium)
        }
        .padding(.top, .small)
    }

}

// MARK: - Preview
#Preview {
    SettingsScreen()
}
