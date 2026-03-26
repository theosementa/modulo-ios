//
//  SwiftUIView.swift
//  DesignSystem
//
//  Created by Theo Sementa on 26/03/2026.
//

import SwiftUI
import Models

public struct ContributionRowView: View {
    
    // MARK: Dependencies
    private let item: ContributionUIModel
    
    // MARK: Init
    public init(
        item: ContributionUIModel
    ) {
        self.item = item
    }
    
    // MARK: - View
    public var body: some View {
        HStack(spacing: .medium) {
            IconButtonView(
                item.type.icon,
                config: .init(
                    iconColor: item.type.color,
                    bgColor: item.type.bgColor
                )
            )
            
            Text(item.name)
                .font(.Body.mediumRegular)
                .fullWidth(.leading)
            
            VStack(alignment: .trailing, spacing: .zero) {
                Text(item.amountFormatted)
                    .font(.Body.largeMedium, color: item.type.color)
                Text(item.dateFormatted)
                    .font(.Body.smallRegular, color: .Text.secondary)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    if let item = ContributionDomain.mocks(for: FinancialGoalDomain.mocks[0].id).first?.toUIModel() {
        ContributionRowView(item: item)
    }
}
