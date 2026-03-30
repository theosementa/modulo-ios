//
//  SwiftUIView.swift
//  Features
//
//  Created by Theo Sementa on 22/03/2026.
//

import SwiftUI
import DesignSystem
import Navigation
import Core

public struct FinancialGoalListScreen: View {
    
    @State private var viewModel: ViewModel = .init()
    @Environment(\.theme) private var theme
    
    public init() { }
    
    // MARK: - View
    public var body: some View {
        VStack(spacing: .zero) {
            NavigationBarView(
                style: .home,
                rightAction: viewModel.navigateToSettings
            )
            
            if viewModel.financialGoals.isEmpty == false {
                List(viewModel.financialGoals) { financialGoal in
                    NavigationButtonView(
                        route: .push,
                        destination: .financialGoal(.details(id: financialGoal.id)),
                        onNavigate: { viewModel.onNavigateSetGoalId(financialGoal.id) },
                        label: { FinancialGoalRowView(item: financialGoal.toUIModel()) }
                    )
                    .disableListStyle()
                    .padding(.bottom, .medium)
                }
                .listStyle(.plain)
                .scrollIndicators(.hidden)
                .contentMargins(.all, .standard, for: .scrollContent)
            } else {
                CustomEmptyView(style: .noTargets)
                    .fullSize()
            }
        }
        .animation(.smooth, value: viewModel.financialGoals)
        .background(Color.Background.bg50)
        .overlay(alignment: .bottomTrailing) {
            NavigationButtonView(
                route: .fullScreenCover,
                destination: .financialGoal(.create),
                onNavigate: { VibrationManager.vibration() },
                label: {
                    IconButtonView(
                        .iconPlus,
                        config: .init(iconColor: .white, bgColor: theme.color)
                    )
                }
            )
            .padding(.large)
        }
        .onAppear { viewModel.onAppearAction() }
    }
}

// MARK: - Preview
#Preview {
    FinancialGoalListScreen()
}
