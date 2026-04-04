//
//  SwiftUIView.swift
//  DesignSystem
//
//  Created by Theo Sementa on 04/04/2026.
//

import SwiftUI

public struct ActionButtonView: View {
    
    // MARK: Constants
    private let text: String
    private let action: () async -> Void
    
    // MARK: Environments
    @Environment(\.theme) private var theme
    
    // MARK: Init
    public init(
        text: String,
        action: @escaping () async -> Void
    ) {
        self.text = text
        self.action = action
    }
    
    // MARK: - View
    public var body: some View {
        Button {
            Task {
                await action()
            }
        } label: {
            Text(text)
                .font(.Body.largeMedium, color: .white)
                .padding(.standard)
                .fullWidth()
                .background(theme.color, in: .rect(cornerRadius: .standard, style: .continuous))
        }
    }
}

// MARK: - Preview
#Preview {
    ActionButtonView(text: "Preview") { }
}
