//
//  SwiftUIView.swift
//  DesignSystem
//
//  Created by Theo Sementa on 25/03/2026.
//

import SwiftUI
import Models

public struct FinancialGoalRowView: View {
    
    // MARK: Dependencies
    private let item: FinancialGoalUIModel
    
    // MARK: Init
    public init(
        item: FinancialGoalUIModel
    ) {
        self.item = item
    }
    
    // MARK: - View
    public var body: some View {
        HStack(spacing: .small) {

            HStack(spacing: .medium) {
                Text(item.emoji)
                    .font(.Title.largeSemiBold)
                    .frame(width: 24, height: 24)
                    .padding(.medium)
                    .background(Color.Background.bg200, in: .rect(cornerRadius: .standard, style: .continuous))
                
                VStack(alignment: .leading, spacing: .zero) {
                    Text(item.name)
                        .font(.Body.smallRegular, color: Color.Text.secondary)
                    Text(item.goalAmountFormatted)
                        .font(.Title.largeSemiBold)
                }
                .fullWidth(.leading)
            }
            
            IconView(.iconChevronRight, color: Color.Text.tertiary)
        }
        .padding(.standard)
        .background(Color.Background.bg100, in: .rect(cornerRadius: .large, style: .continuous))
    }
}

// MARK: - Preview
#Preview {
    FinancialGoalRowView(item: FinancialGoalDomain.mock.toUIModel())
}
