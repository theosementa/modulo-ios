//
//  SwiftUIView.swift
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
    
    // MARK: States
    @State private var viewModel: ViewModel
    
    // MARK: Init
    init(id: String) {
        self.id = id
        self._viewModel = State(wrappedValue: ViewModel(id: id))
    }
    
    // MARK: - View
    var body: some View {
        VStack(spacing: .zero) {
            NavigationBarView(
                style: .push(title: viewModel.detailledGoal?.toUIModel().name ?? ""),
                rightAction: { viewModel.navigateToEdition() },
                leftAction: { viewModel.router?.dismiss() }
            )
            
            if let goal = viewModel.detailledGoal?.toUIModel() {
                ScrollView {
                    VStack(spacing: .large) {
                        if goal.remainingThisMonthFormatted != nil {
                            toContributeThisMonthSectionView(goal)
                            DividerView()
                        }
                        generalSectionView(goal)
                        DividerView()
                        monthlySectionView(goal)
                        DividerView()
                        dateSectionView(goal)
                        DividerView()
                        contributionsSectionView()
                    }
                    .padding(.standard)
                }
                .scrollIndicators(.hidden)
                .contentMargins(.bottom, .massive, for: .scrollContent)
                .task { viewModel.loadMonthlyDataPoints() }
                .onChange(of: viewModel.detailledGoal?.goal.currentAmount) {
                    viewModel.loadMonthlyDataPoints()
                }
            }
        }
        .fullSize(.top)
        .background(Color.Background.bg50)
        .navigationBarBackButtonHidden(true)
        .overlay(alignment: .bottomTrailing) {
            NavigationButtonView(
                route: .fullScreenCover,
                destination: .contribution(.create(goalId: viewModel.goalId)),
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
            if viewModel.isChartDisplayed {
                ContributionLineChartView(dataPoints: viewModel.monthlyDataPoints)
            }
            
            ProgressBarView(percentage: goal.progress)
            
            ValueWithLabelView(
                value: goal.goalAmountFormatted,
                label: "financial_goal_detail_general_section_target".localized
            )
            
            HStack(spacing: .medium) {
                ValueWithLabelView(
                    value: goal.currentContributionsFormatted,
                    label: "financial_goal_detail_general_section_total_contribution".localized
                )
                
                ValueWithLabelView(
                    value: goal.remainingContributionsFormatted,
                    label: "financial_goal_detail_general_section_remaining_contribution".localized
                )
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
                        icon: .iconTarget,
                        text: "financial_goal_detail_monthly_section_theorical_target".localized,
                        value: goal.monthlyTargetFormatted ?? ""
                    )
                    
                    DetailRowView(
                        icon: .iconTarget,
                        text: "financial_goal_detail_monthly_section_recalculed_target".localized,
                        value: goal.monthlyRequiredFormatted ?? ""
                    )
                }
                
                DetailRowView(
                    icon: .iconHandCoins,
                    text: "financial_goal_detail_monthly_section_contributed_this_month".localized,
                    value: goal.contribuedThisMonthFormatted
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
                    icon: .iconSablier,
                    text: "financial_goal_detail_date_section_elapsed_days".localized,
                    value: goal.date.elapsedDaysFormatted
                )
                
                if let remainingDays = goal.date.remainingDaysFormatted {
                    DetailRowView(
                        icon: .iconRemaningTime,
                        text: "financial_goal_detail_date_section_remaining_days".localized,
                        value: remainingDays
                    )
                }
                
                DetailRowView(
                    icon: .iconCalendar,
                    text: "generic_start_date".localized,
                    value: goal.date.startDateFormatted
                )
                
                if let endDate = goal.date.endDateFormatted {
                    DetailRowView(
                        icon: .iconCalendar,
                        text: "generic_end_date".localized,
                        value: endDate
                    )
                }
            }
        }
    }
    
    func contributionsSectionView() -> some View { // TODO: TBL
        VStack(alignment: .leading, spacing: .standard) {
            Text("Contributions")
                .font(.Title.largeSemiBold)

            if viewModel.contributions.isEmpty {
                Text("Aucune contribution pour le moment")
                    .font(.Body.mediumRegular)
                    .fullWidth()
            } else {
                VStack(spacing: .medium) {
                    ForEach(viewModel.contributions) { contribution in
                        ContributionRowView(item: contribution.toUIModel())
                    }
                }
            }
        }
        .task {
            viewModel.fetchAllContributions()
        }
    }
    
}

// MARK: - Preview
#Preview {
    FinancialGoalDetailsScreen(id: FinancialGoalDomain.mocks[0].id)
}
