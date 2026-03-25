//
//  DeleteNumberButtonView.swift
//  DesignSystem
//
//  Created by Theo Sementa on 25/03/2026.
//

import SwiftUI
import Core

public struct DeleteNumberButtonView: View {
    
    // MARK: Dependencies
    @Binding var amount: String
    
    // MARK: Init
    public init(amount: Binding<String>) {
        self._amount = amount
    }
    
    // MARK: - View
    public var body: some View {
        Button {
            if amount == "0" { return }
            amount.removeLast()
            if amount.isEmpty { amount = "0" }
            VibrationManager.vibration()
        } label: {
            IconView(.iconDelete, size: .mediumLarge, color: .Text.secondary)
                .padding(6)
                .background(Color.Background.bg100, in: .circle)
        }
    }
}

// MARK: - Preview
#Preview {
    @Previewable @State var amount: String = "252"
    DeleteNumberButtonView(amount: $amount)
}
