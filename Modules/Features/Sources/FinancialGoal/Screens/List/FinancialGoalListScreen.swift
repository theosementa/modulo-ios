//
//  SwiftUIView.swift
//  Features
//
//  Created by Theo Sementa on 22/03/2026.
//

import SwiftUI
import DesignSystem

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
                FinancialGoalRowView(item: financialGoal.toUIModel())
            }
            .disableListStyle()
        }
        .background(Color.Background.bg50)
    }
}

// MARK: - Preview
#Preview {
    FinancialGoalListScreen()
}
