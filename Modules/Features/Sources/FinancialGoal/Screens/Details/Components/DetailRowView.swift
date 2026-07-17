//
//  SwiftUIView.swift
//  Features
//
//  Created by Theo Sementa on 16/07/2026.
//

import SwiftUI
import Models
import DesignSystem

enum DetailRowViewStyle {
    case small, big
}

struct DetailRowView: View {
    
    // MARK: Dependencies
    private let style: DetailRowViewStyle
    private let value: String
    private let title: String
    private let description: String
    
    // MARK: Environment
    @Environment(\.theme) private var theme
    
    // MARK: Init
    public init(
        style: DetailRowViewStyle,
        value: String,
        title: String,
        description: String,
    ) {
        self.style = style
        self.value = value
        self.title = title
        self.description = description
    }
    
    // MARK: -
    var body: some View {
        if style == .small {
            HStack(spacing: .medium) {
                valueTextView
                labelsView
            }
        } else {
            VStack(alignment: .leading, spacing: .tiny) {
                valueTextView
                labelsView
            }
            .padding(.medium)
            .background(Color.Background.bg100, in: .rect(cornerRadius: .mediumLarge, style: .continuous))
        }
    }
}

// MARK: - Subviews
fileprivate extension DetailRowView {
    
    var valueTextView: some View {
        Text(value)
            .font(.Body.largeSemiBold, color: theme.color)
            .padding(.horizontal, .small)
            .padding(.vertical, .tiny)
            .background(theme.backgroundColor, in: .rect(cornerRadius: .medium, style: .continuous))
    }
    
    var labelsView: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text(title)
                .font(.Body.mediumRegular)
            Text(description)
                .font(.Label.largeMedium, color: .Text.secondary)
        }
        .fullWidth(.leading)
    }
    
}

// MARK: - Preview
#Preview {
    DetailRowView(
        style: .small,
        value: "833 €",
        title: "Initial plan",
        description: "Based on your goal and deadline"
    )
}
