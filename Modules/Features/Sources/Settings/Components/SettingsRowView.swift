//
//  SwiftUIView.swift
//  Features
//
//  Created by Theo Sementa on 30/03/2026.
//

import SwiftUI
import Models
import DesignSystem

public enum SettingsRowStyle {
    case casual, destructive
}

public struct SettingsRowView<Content: View>: View {

    // MARK: Dependencies
    private let icon: ImageType
    private let text: String
    private let style: SettingsRowStyle
    private let rightContent: Content?

    // MARK: Init
    public init(
        icon: ImageType,
        text: String,
        style: SettingsRowStyle,
        @ViewBuilder rightContent: @escaping () -> Content
    ) {
        self.icon = icon
        self.text = text
        self.style = style
        self.rightContent = rightContent()
    }

    // MARK: - View
    public var body: some View {
        HStack(spacing: .small) {
            IconView(icon, size: .standard, color: .white)
                .padding(.medium)
                .background(style == .destructive ? Color.Error.e500 : Color.Text.tertiary, in: .rect(cornerRadius: .medium, style: .continuous))

            Text(text)
                .font(.Body.mediumRegular, color: style == .destructive ? Color.Error.e500 : Color.Text.primary)
                .fullWidth(.leading)

            if let rightContent {
                rightContent
            } else {
                IconView(.iconArrowUpDiagonal, color: .Text.tertiary)
            }
        }
    }
}

public extension SettingsRowView where Content == EmptyView {
    init(
        icon: ImageType,
        text: String,
        style: SettingsRowStyle
    ) {
        self.icon = icon
        self.text = text
        self.style = style
        self.rightContent = nil
    }
}

// MARK: - Preview
#Preview {
    SettingsRowView(icon: .iconStar, text: "Review the appp", style: .casual)
}
