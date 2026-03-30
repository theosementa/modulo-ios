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
                }
            }
            .contentMargins(.all, .standard, for: .scrollContent)
        }
        .navigationBarBackButtonHidden(true)
        .background(Color.Background.bg50)
    }
}

// MARK: - Subview
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
                            Text(theme.rawValue)
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
    
    
}

// MARK: - Preview
#Preview {
    SettingsScreen()
}
