//
//  SwiftUIView.swift
//  DesignSystem
//
//  Created by Theo Sementa on 26/03/2026.
//

import SwiftUI
import Models
import Stores

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
        .contentShape(Rectangle())
        .contentShape(.contextMenuPreview, RoundedRectangle(cornerRadius: .medium, style: .continuous))
        .contextMenu {
            Button(role: .destructive) {
               // TODO: Ask with alert
                DefaultContributionStore.shared.delete(by: item.id)
            } label: {
                Label {
                    Text("generic_delete".localized)
                        .font(.Body.mediumMedium, color: .Error.e500)
                } icon: {
                    IconView(.iconTrash, size: .medium, color: .Error.e500)
                }
            }
        } preview: {
            self
                .frame(width: UIScreen.main.bounds.width - (.standard * 2))
                .padding(.small)
        }
    }
}

// MARK: - Preview
#Preview {
    if let item = ContributionDomain.mocks(for: FinancialGoalDomain.mocks[0].id).first?.toUIModel() {
        ContributionRowView(item: item)
    }
}
