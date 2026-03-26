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
                Text(goal.goalAmountFormatted)
                Text(goal.currentContributionsFormatted)
                Text(goal.remainingContributionsFormatted)
                Text(goal.remainingThisMonthFormatted ?? "")
                Spacer()
                Text(goal.monthlyTargetFormatted ?? "")
                Text(goal.monthlyRequiredFormatted ?? "")
                Text(goal.contribuedThisMonthFormatted)
                Spacer()
                Text(goal.date.elapsedDaysFormatted)
                Text(goal.date.remainingDaysFormatted ?? "")
                Text(goal.date.startDateFormatted)
                Text(goal.date.endDateFormatted ?? "")
                Spacer()
            }
        }
        .fullSize(.top)
        .background(Color.Background.bg50)
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: - Preview
#Preview {
    FinancialGoalDetailsScreen(id: FinancialGoalDomain.mock.id)
}
