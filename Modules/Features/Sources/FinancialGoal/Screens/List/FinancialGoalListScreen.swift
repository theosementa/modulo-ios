//
//  SwiftUIView.swift
//  Features
//
//  Created by Theo Sementa on 22/03/2026.
//

import SwiftUI
import Core
import DesignSystem
import Navigation
import Presenters
import Models

public struct FinancialGoalListScreen: View {

    // MARK: Dependencies
    private let presenter: FinancialGoalPresenter

    // MARK: Environments
    @Environment(\.theme) private var theme
    @Environment(Router<AppDestination>.self) private var router

    // MARK: Init
    public init(presenter: FinancialGoalPresenter = DefaultFinancialGoalPresenter.shared) {
        self.presenter = presenter
    }

    // MARK: - View
    public var body: some View {
        VStack(spacing: .zero) {
            NavigationBarView(
                style: .home,
                rightAction: { router.push(.settings(.list)) }
            )

            if sortedGoals.isEmpty == false {
                List(sortedGoals) { financialGoal in
                    NavigationButtonView(
                        target: .push(.financialGoal(.details(id: financialGoal.id))),
                        onNavigate: { presenter.dataSource.currentGoalId = financialGoal.id },
                        label: { FinancialGoalRowView(item: financialGoal.toUIModel()) }
                    )
                    .disableListStyle()
                    .padding(.bottom, .medium)
                }
                .listStyle(.plain)
                .scrollIndicators(.hidden)
                .contentMargins(.all, .standard, for: .scrollContent)
            } else {
                CustomEmptyView(style: .noGoals)
                    .fullSize()
            }
        }
        .animation(.smooth, value: sortedGoals)
        .background(Color.Background.bg50)
        .overlay(alignment: .bottomTrailing) {
            NavigationButtonView(
                target: .fullScreenCover(.financialGoal(.addFlow)),
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
        .onAppear { presenter.dataSource.fetchAll() }
    }
}

// MARK: - Computed variables
private extension FinancialGoalListScreen {

    var sortedGoals: [FinancialGoalDomain] {
        presenter.goals(sortedBy: .goalAmount)
    }

}

// MARK: - Preview
#Preview {
    FinancialGoalListScreen()
}
