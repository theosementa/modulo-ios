//
//  SwiftUIView.swift
//  DesignSystem
//
//  Created by Theo Sementa on 25/03/2026.
//

import Core
import Models
import SwiftUI

public struct IconButtonView: View {
    
    // MARK: Dependencies
    private let icon: ImageType
    private let action: (() -> Void)?
    
    // MARK: Init
    public init(
        _ icon: ImageType,
        action: (() -> Void)? = nil
    ) {
        self.icon = icon
        self.action = action
    }
    
    // MARK: - View
    public var body: some View {
        Button {
            VibrationManager.vibration()
            if let action { action() }
        } label: {
            IconView(icon)
                .padding(10)
                .background(Color.Background.bg100, in: .rect(cornerRadius: .standard, style: .continuous))
        }
        .disabled(action == nil)
    }
}

// MARK: - Preview
#Preview {
    IconButtonView(.iconLock) { }
}
