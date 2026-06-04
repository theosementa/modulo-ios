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
import ToastBannerKit

public struct FinancialGoalRowView: View {

    // MARK: Dependencies
    private let item: FinancialGoalUIModel
    private let style: Style

    // MARK: Environments
    @Environment(Router<AppDestination>.self) private var router
    @Environment(\.theme) private var theme

    // MARK: States
    @State private var isAlertPresented: Bool = false

    // MARK: Init
    public init(
        item: FinancialGoalUIModel,
        style: Style = .detailed
    ) {
        self.item = item
        self.style = style
    }

    // MARK: - View
    public var body: some View {
        Group {
            switch style {
            case .default:
                defaultLayout
            case .detailed:
                detailedLayout
            }
        }
        .contentShape(.contextMenuPreview, .rect(cornerRadius: .large))
        .confirmationAlert(.deletion, isPresented: $isAlertPresented) {
            DefaultFinancialGoalStore.shared.delete(by: item.id)
            ToastBannerService.shared.send(.successGoalDeleted)
        }
        .contextMenu {
            Button {
                router.present(route: .fullScreenCover, .financialGoal(.update(id: item.id)))
            } label: {
                Label {
                    Text("generic_edit".localized)
                        .font(.Body.mediumMedium, color: Color.Text.primary)
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

// MARK: - Style

extension FinancialGoalRowView {
    public enum Style {
        case `default`
        case detailed
    }
}

// MARK: - Layouts

private extension FinancialGoalRowView {

    @ViewBuilder
    var defaultLayout: some View {
        HStack(spacing: .small) {
            HStack(spacing: .medium) {
                Text(item.emoji)
                    .font(.Title.largeSemiBold, color: Color.Text.primary)
                    .frame(width: 24, height: 24)
                    .padding(.medium)
                    .background(Color.Background.bg200, in: .rect(cornerRadius: .standard, style: .continuous))

                VStack(alignment: .leading, spacing: .zero) {
                    Text(item.name)
                        .font(.Body.smallRegular, color: Color.Text.secondary)
                    Text(item.currentAmountFormatted)
                        .font(.Title.largeSemiBold, color: Color.Text.primary)
                        .contentTransition(.numericText())
                }
                .fullWidth(.leading)
            }

            IconView(.iconChevronRight, color: Color.Text.tertiary)
        }
        .padding(.standard)
        .background(Color.Background.bg100, in: .rect(cornerRadius: .large, style: .continuous))
    }

    @ViewBuilder
    var detailedLayout: some View {
        VStack(spacing: .standard) {
            HStack(alignment: .center, spacing: .medium) {
                Text(item.emoji)
                    .font(.Title.largeSemiBold, color: Color.Text.primary)
                    .padding(.medium)
                    .background(Color.Background.bg200, in: .rect(cornerRadius: .standard, style: .continuous))

                VStack(alignment: .leading, spacing: .zero) {
                    HStack(alignment: .lastTextBaseline, spacing: .tiny) {
                        Text(item.currentAmountFormatted)
                            .font(.Title.largeSemiBold, color: .Text.primary)
                            .contentTransition(.numericText())
                        
                        Text("/ \(item.goalAmountFormatted)")
                            .font(.Body.mediumMedium, color: .Text.tertiary)
                    }
                    Text(item.name)
                        .font(.Body.smallRegular, color: Color.Text.secondary)
                }
                .fullWidth(.leading)
            }

            HStack(spacing: .medium) {
                tallyBar
                percentBadge
            }
        }
        .padding(.standard)
        .background(Color.Background.bg100, in: .rect(cornerRadius: .large, style: .continuous))
    }

    var tallyBar: some View {
        GeometryReader { proxy in
            let stick: CGFloat = 4
            let gap: CGFloat = .tiny
            let count = max(1, Int((proxy.size.width + gap) / (stick + gap)))
            let filled = min(max(Int((Double(count) * item.progressRatio).rounded()), 0), count)
            HStack(spacing: gap) {
                ForEach(0..<count, id: \.self) { index in
                    Capsule()
                        .fill(index < filled ? theme.color : Color.Background.bg200)
                        .frame(width: stick, height: 24)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 24)
    }

    var percentBadge: some View {
        Text(item.progressPercentFormatted)
            .font(.Label.largeMedium, color: theme.color)
            .padding(.horizontal, .small)
            .padding(.vertical, .tiny)
            .background(theme.color.opacity(0.15), in: .rect(cornerRadius: .small, style: .continuous))
    }
}

// MARK: - Preview
#Preview("Default") {
    FinancialGoalRowView(item: FinancialGoalDomain.mocks[0].toUIModel())
        .padding(.standard)
}

#Preview("Both styles") {
    VStack(spacing: .standard) {
        FinancialGoalRowView(item: FinancialGoalDomain.mocks[0].toUIModel(), style: .default)
        FinancialGoalRowView(item: FinancialGoalDomain.mocks[0].toUIModel(), style: .detailed)
    }
    .padding(.standard)
}
