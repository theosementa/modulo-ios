//
//  FinancialGoalDetailsScreen.swift
//  Features
//
//  Created by Theo Sementa on 26/03/2026.
//

import SwiftUI
import Models
import DesignSystem
import Navigation
import Core

struct FinancialGoalDetailsScreen: View {

    // MARK: Dependencies
    private let id: String

    // MARK: Environments
    @Environment(\.theme) private var theme
    @Environment(Router<AppDestination>.self) private var router
    @Environment(\.safeAreaInsets) private var safeAreaInsets

    // MARK: States
    @State private var store: DefaultFinancialGoalDetailsStore = .init()
    @State private var navigationBarHeight: CGFloat = 0
    @State private var toContributeSectionHeight: CGFloat = 0
    @State private var generalSectionHeight: CGFloat = 0
    @State private var scrollOffset: CGFloat = 0

    // MARK: Init
    init(id: String) {
        self.id = id
    }

    // MARK: Computed variables
    private var meshGradientBaseHeight: CGFloat {
        navigationBarHeight + toContributeSectionHeight + generalSectionHeight + .large + (.huge / 2)
    }

    private var meshGradientHeight: CGFloat {
        max(navigationBarHeight, meshGradientBaseHeight - scrollOffset + safeAreaInsets.top)
    }

    // MARK: - View
    var body: some View {
        VStack(spacing: .zero) {
            NavigationBarView(
                style: .push(title: store.detailledGoal?.toUIModel().name ?? ""),
                rightAction: { store.send(.editTapped) },
                leftAction: { store.send(.dismissTapped) },
                hasBackground: false
            )
            .getSize { size in
                navigationBarHeight = size.height
            }

            if let goal = store.detailledGoal?.toUIModel() {
                ScrollView {
                    VStack(spacing: .huge) {
                        if goal.remainingThisMonthFormatted != nil {
                            toContributeThisMonthSectionView(goal)
                                .getSize { size in
                                    toContributeSectionHeight = size.height
                                }
                            DividerView(color: Color.Base.white)
                        }
                        
                        generalSectionView(goal)
                            .getSize { size in
                                generalSectionHeight = size.height
                            }
                        
                        monthlySectionView(goal)
                        
                        DividerView()
                        
                        dateSectionView(goal)
                        
                        DividerView()
                        
                        contributionsSectionView()
                    }
                    .padding(.large)
                }
                .scrollIndicators(.hidden)
                .contentMargins(.bottom, .massive, for: .scrollContent)
                .task { store.send(.loadMonthlyDataPoints) }
                .onChange(of: store.detailledGoal?.goal.currentAmount) {
                    store.send(.loadMonthlyDataPoints)
                }
                .onScrollGeometryChange(for: CGFloat.self) { geometry in
                    geometry.contentOffset.y + geometry.contentInsets.top
                } action: { _, newValue in
                    scrollOffset = newValue
                }
            }
        }
        .fullSize(.top)
        .background {
            VStack(spacing: .zero) {
                meshGradientView
                    .ignoresSafeArea(.all, edges: .top)
                    .frame(height: meshGradientHeight)
                Color.Background.bg50
                    .ignoresSafeArea(.all, edges: .bottom)
            }
        }
        .navigationBarBackButtonHidden(true)
        .overlay(alignment: .bottomTrailing) {
            SmallActionButtonView(
                style: .withValue(bgColor: theme.color),
                icon: .iconPlusRounded,
                text: "Add a contribution", // TODO: TBL
                config: .init(hasLiquidGlass: true)
            ) {
                VibrationManager.vibration()
                router.present(route: .fullScreenCover, .contribution(.create(goalId: store.state.goalId)))
            }
            .padding(.large)
        }
        .task {
            store.send(.bootstrap(goalId: id))
            await observeSideEffects()
        }
    }
}

// MARK: - Subviews
fileprivate extension FinancialGoalDetailsScreen {

    func toContributeThisMonthSectionView(_ goal: FinancialGoalDetailedUIModel) -> some View {
        VStack(spacing: .zero) {
            Text(goal.remainingThisMonthFormatted ?? "")
                .font(.Title.largeSemiBold)
            Text("financial_goal_detail_to_contribute_this_month".localized)
                .font(.Body.mediumRegular)
        }
    }

    func generalSectionView(_ goal: FinancialGoalDetailedUIModel) -> some View {
        VStack(spacing: .medium) {
//            if store.state.isChartDisplayed {
//                ContributionLineChartView(dataPoints: store.state.monthlyDataPoints)
//            }

            ProgressBarView(percentage: goal.progress)

            HStack(spacing: .small) {
                VStack(alignment: .leading, spacing: .zero) {
                    Text("financial_goal_detail_general_section_total_contribution".localized)
                        .font(.Body.smallRegular, color: Color(uiColor: .secondaryLabel))
                    Text(goal.currentContributionsFormatted)
                        .font(.Title.largeSemiBold, color: Color(uiColor: .label))
                }
                .fullWidth(.leading)
                
                VStack(alignment: .trailing, spacing: .zero) {
                    Text("financial_goal_detail_general_section_remaining_contribution".localized)
                        .font(.Body.smallRegular, color: Color(uiColor: .secondaryLabel))
                    Text(goal.remainingContributionsFormatted)
                        .font(.Title.largeSemiBold, color: Color(uiColor: .label))
                }
                .fullWidth(.trailing)
            }
        }
    }

    @ViewBuilder
    func monthlySectionView(_ goal: FinancialGoalDetailedUIModel) -> some View {
        VStack(alignment: .leading, spacing: .standard) {
            Text("financial_goal_detail_monthly_section_title".localized)
                .font(.Title.largeSemiBold)

            VStack(spacing: .medium) {
                if goal.date.endDateFormatted != nil {
                    DetailRowView(
                        style: .big,
                        value: goal.monthlyTargetFormatted ?? "",
                        title: "financial_goal_detail_monthly_section_theorical_target".localized,
                        description: "Based on your goal and deadline"
                    )
                    
                    DetailRowView(
                        style: .big,
                        value: goal.monthlyRequiredFormatted ?? "",
                        title: "financial_goal_detail_monthly_section_recalculed_target".localized,
                        description: "Recalculated from your current progress"
                    )
                }
                
                DetailRowView(
                    style: .big,
                    value: goal.contribuedThisMonthFormatted,
                    title: "financial_goal_detail_monthly_section_contributed_this_month".localized,
                    description: "Added to your goal this month"
                )
            }
        }
    }

    func dateSectionView(_ goal: FinancialGoalDetailedUIModel) -> some View {
        VStack(alignment: .leading, spacing: .standard) {
            Text("generic_date".localized)
                .font(.Title.largeSemiBold)

            VStack(spacing: .medium) {
                DetailRowView(
                    style: .small,
                    value: goal.date.elapsedDaysFormatted,
                    title: "financial_goal_detail_date_section_elapsed_days".localized,
                    description: "Since \(goal.date.startDateFormatted)"
                )

                if let remainingDays = goal.date.remainingDaysFormatted, let endDate = goal.date.endDateFormatted {
                    DetailRowView(
                        style: .small,
                        value: remainingDays,
                        title: "financial_goal_detail_date_section_remaining_days".localized,
                        description: "Until \(endDate)"
                    )
                }
            }
        }
    }

    func contributionsSectionView() -> some View { // TODO: TBL
        VStack(alignment: .leading, spacing: .standard) {
            Text("Contributions")
                .font(.Title.largeSemiBold)

            if store.contributions.isEmpty {
                Text("Aucune contribution pour le moment")
                    .font(.Body.mediumRegular)
                    .fullWidth()
            } else {
                VStack(spacing: .medium) {
                    ForEach(store.contributions) { contribution in
                        ContributionRowView(item: contribution.toUIModel())
                    }
                }
            }
        }
        .task {
            store.send(.fetchContributions)
        }
    }
    
    var meshGradientView: some View {
        Group {
            if #available(iOS 18.0, *) {
                MeshGradient(
                    width: 2, height: 2,
                    points: [
                        [0, 0], [1, 0],
                        [0, 1], [1, 1]
                    ],
                    colors: [
                        Color.Background.bg50, theme.color, theme.color, Color.Background.bg50
                    ]
                )
            } else {
                theme.color
            }
        }
    }

}

// MARK: - Private methods
fileprivate extension FinancialGoalDetailsScreen {

    func observeSideEffects() async {
        for await effect in store.sideEffects {
            switch effect {
            case .dismiss:
                router.dismiss()
            case .navigateToEdit(let goalId):
                router.present(route: .fullScreenCover, .financialGoal(.update(id: goalId)))
            }
        }
    }

}

// MARK: - Preview
#Preview {
    FinancialGoalDetailsScreen(id: FinancialGoalDomain.mocks[0].id)
}
