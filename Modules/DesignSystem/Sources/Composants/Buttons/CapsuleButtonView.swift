//
//  SwiftUIView.swift
//  DesignSystem
//
//  Created by Theo Sementa on 28/03/2026.
//

import SwiftUI
import Models

public struct CapsuleButtonView: View {
    
    // MARK: Environments
    @Environment(\.theme) private var theme
    
    // MARK: Dependencies
    private let text: String
    private let icon: ImageType
    private let action: () -> Void
    
    // MARK: Init
    public init(
        text: String,
        icon: ImageType,
        action: @escaping () -> Void
    ) {
        self.text = text
        self.icon = icon
        self.action = action
    }
    
    // MARK: - View
    public var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: .tiny) {
                Text(text)
                    .font(.Body.largeSemiBold, color: .white)
                IconView(icon, size: .mediumLarge, color: .white)
            }
            .padding(.horizontal, .medium)
            .padding(.vertical, .small)
            .background(theme.color, in: .capsule)
        }
    }
}

// MARK: - Preview
#Preview {
    CapsuleButtonView(text: "Preview", icon: .iconPlus) { }
}
