//
//  SwiftUIView.swift
//  Features
//
//  Created by Theo Sementa on 26/03/2026.
//

import SwiftUI
import Models
import DesignSystem

struct FinancialGoalDetailsScreen: View {
    
    // MARK: Dependencies
    private let id: String
    
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
                rightAction: { },
                leftAction: { viewModel.router?.dismiss() }
            )
            
            if let goal = viewModel.detailledGoal?.toUIModel() {
                ScrollView {
                    VStack(spacing: .large) {
                        Text(goal.remainingThisMonthFormatted ?? "")
                        DividerView()
                        generalSectionView(goal)
                        DividerView()
                        monthlySectionView(goal)
                        DividerView()
                        dateSectionView(goal)
                    }
                    .padding(.standard)
                }
                .scrollIndicators(.hidden)
            }
        }
        .fullSize(.top)
        .background(Color.Background.bg50)
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: - Subviews
fileprivate extension FinancialGoalDetailsScreen {
    
    func generalSectionView(_ goal: FinancialGoalDetailedUIModel) -> some View { // TODO: TBL
        VStack(spacing: .medium) {
            ValueWithLabelView(
                value: goal.goalAmountFormatted,
                label: "Objectif"
            )
            
            HStack(spacing: .medium) {
                ValueWithLabelView(
                    value: goal.currentContributionsFormatted,
                    label: "Contribution totale"
                )
                
                ValueWithLabelView(
                    value: goal.remainingContributionsFormatted,
                    label: "Contribution restante"
                )
            }
        }
    }
    
    @ViewBuilder
    func monthlySectionView(_ goal: FinancialGoalDetailedUIModel) -> some View { // TODO: TBL
        VStack(alignment: .leading, spacing: .standard) {
            Text("Mensualité")
                .font(.Title.largeSemiBold)
            
            VStack(spacing: .medium) {
                if goal.date.endDateFormatted != nil {
                    DetailRowView(
                        icon: .iconTarget,
                        text: "Objectif théorique",
                        value: goal.monthlyTargetFormatted ?? ""
                    )
                    
                    DetailRowView(
                        icon: .iconTarget,
                        text: "Objectif recalculé",
                        value: goal.monthlyRequiredFormatted ?? ""
                    )
                }
                
                DetailRowView(
                    icon: .iconHandCoins,
                    text: "Contribué ce mois-ci",
                    value: goal.contribuedThisMonthFormatted
                )
            }
        }
    }
    
    func dateSectionView(_ goal: FinancialGoalDetailedUIModel) -> some View { // TODO: TBL
        VStack(alignment: .leading, spacing: .standard) {
            Text("Date")
                .font(.Title.largeSemiBold)
            
            VStack(spacing: .medium) {
                DetailRowView(
                    icon: .iconSablier,
                    text: "Jours écoulés",
                    value: goal.date.elapsedDaysFormatted
                )
                
                if let remainingDays = goal.date.remainingDaysFormatted {
                    DetailRowView(
                        icon: .iconRemaningTime,
                        text: "Jours restants",
                        value: remainingDays
                    )
                }
                
                DetailRowView(
                    icon: .iconCalendar,
                    text: "Date de début",
                    value: goal.date.startDateFormatted
                )
                
                if let endDate = goal.date.endDateFormatted {
                    DetailRowView(
                        icon: .iconCalendar,
                        text: "Date de fin",
                        value: endDate
                    )
                }
            }
        }
    }
    
}

// MARK: - Preview
#Preview {
    FinancialGoalDetailsScreen(id: FinancialGoalDomain.mock.id)
}
