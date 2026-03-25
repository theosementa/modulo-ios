//
//  SwiftUIView.swift
//  Features
//
//  Created by Theo Sementa on 22/03/2026.
//

import SwiftUI
import Models

struct FinancialGoalRowView: View {
    
    // MARK: Dependencies
    private let item: FinancialGoalUIModel
    
    // MARK: Init
    init(item: FinancialGoalUIModel) {
        self.item = item
    }
    
    // MARK: - View
    var body: some View {
        HStack(spacing: .small) {
            Text(item.emoji)
                .font(.title2)
                .frame(width: 24, height: 24)
                .padding(.medium)
                .background(Color.Background.tertiary)
            
            VStack(alignment: .leading, spacing: .zero) {
                Text(item.name)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    FinancialGoalRowView(item: FinancialGoalDomain.mock.toUIModel())
}
