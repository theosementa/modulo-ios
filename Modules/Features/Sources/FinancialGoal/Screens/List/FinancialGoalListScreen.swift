//
//  SwiftUIView.swift
//  Features
//
//  Created by Theo Sementa on 22/03/2026.
//

import SwiftUI
import DesignSystem
import Navigation

public struct FinancialGoalListScreen: View {
    
    @State private var viewModel: ViewModel = .init()
    
    public init() { }
    
    // MARK: - View
    public var body: some View {
        VStack(spacing: .zero) {
            NavigationBarView(
                style: .home,
                rightAction: { }
            )
            
            List(viewModel.financialGoals) { financialGoal in
                NavigationButtonView(
                    route: .push,
                    destination: .financialGoal(.details(id: financialGoal.id))
                ) {
                    FinancialGoalRowView(item: financialGoal.toUIModel())
                }
                .disableListStyle()
                .padding(.bottom, .medium)
            }
            .listStyle(.plain)
            .scrollIndicators(.hidden)
            .contentMargins(.all, .standard, for: .scrollContent)
        }
        .background(Color.Background.bg50)
        .overlay(alignment: .bottomTrailing) {
            NavigationButtonView(
                route: .fullScreenCover,
                destination: .financialGoal(.create)
            ) {
                IconButtonView(.iconPlus)
            }
            .padding(.large)
        }
        .onAppear { viewModel.onAppearAction() }
    }
}

// MARK: - Preview
#Preview {
    FinancialGoalListScreen()
}
