//
//  SwiftUIView.swift
//  DesignSystem
//
//  Created by Theo Sementa on 26/03/2026.
//

import SwiftUI
import Models

public struct DetailRowView: View {
    
    // MARK: Dependencies
    private let icon: ImageType
    private let text: String
    private let value: String
    
    // MARK: Init
    public init(
        icon: ImageType,
        text: String,
        value: String
    ) {
        self.icon = icon
        self.text = text
        self.value = value
    }
    
    // MARK: - View
    public var body: some View {
        HStack(spacing: .small) {
            IconView(icon, size: .mediumLarge)
            Text(text)
                .font(.Body.mediumRegular)
                .fullWidth(.leading)
            Text(value)
                .font(.Body.largeSemiBold)
        }
    }
}

// MARK: - Preview
#Preview {
    DetailRowView(icon: .iconTarget, text: "Objectif", value: 300.toCurrency())
}
