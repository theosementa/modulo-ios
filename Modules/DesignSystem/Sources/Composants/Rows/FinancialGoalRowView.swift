//
//  SwiftUIView.swift
//  DesignSystem
//
//  Created by Theo Sementa on 25/03/2026.
//

import SwiftUI
import Models
import Stores
import Navigation

public struct FinancialGoalRowView: View {
    
    // MARK: Dependencies
    private let item: FinancialGoalUIModel
    
    // MARK: Environments
    @Environment(Router<AppDestination>.self) private var router
    
    // MARK: States
    @State private var isAlertPresented: Bool = false
    
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
                    Text(item.currentAmountFormatted)
                        .font(.Title.largeSemiBold)
                        .contentTransition(.numericText())
                }
                .fullWidth(.leading)
            }
            
            IconView(.iconChevronRight, color: Color.Text.tertiary)
        }
        .padding(.standard)
        .background(Color.Background.bg100, in: .rect(cornerRadius: .large, style: .continuous))
        .contentShape(.contextMenuPreview, .rect(cornerRadius: .large))
        .confirmationAlert(.deletion, isPresented: $isAlertPresented) {
            DefaultFinancialGoalStore.shared.delete(by: item.id)
        }
        .contextMenu {
            Button {
                router.present(route: .fullScreenCover, .financialGoal(.update(id: item.id)))
            } label: {
                Label {
                    Text("generic_edit".localized)
                        .font(.Body.mediumMedium)
                } icon: {
                    IconView(.iconPencil, size: .medium)
                }
            }
            
            Button(role: .destructive) {
                isAlertPresented = true
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
        }
    }
}

// MARK: - Preview
#Preview {
    FinancialGoalRowView(item: FinancialGoalDomain.mock.toUIModel())
}
