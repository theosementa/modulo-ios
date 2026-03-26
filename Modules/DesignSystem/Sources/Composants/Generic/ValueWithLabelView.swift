//
//  SwiftUIView.swift
//  DesignSystem
//
//  Created by Theo Sementa on 26/03/2026.
//

import SwiftUI

public struct ValueWithLabelView: View {
    
    // MARK: Dependencies
    private let value: String
    private let label: String
    
    // MARK: Init
    public init(
        value: String,
        label: String
    ) {
        self.value = value
        self.label = label
    }
    
    // MARK: - View
    public var body: some View {
        VStack(spacing: .zero) {
            Text(value)
                .font(.Title.mediumMedium)
            Text(label)
                .font(.Body.smallRegular)
        }
        .fullWidth()
        .padding(.standard)
        .background(Color.Background.bg100, in: .rect(cornerRadius: .mediumLarge, style: .continuous))
    }
}

// MARK: - Preview
#Preview {
    ValueWithLabelView(value: 50000.toCurrency(), label: "Objectif")
}
