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
    private let config: Configuration
    private let action: (() -> Void)?
    
    // MARK: Init
    public init(
        _ icon: ImageType,
        config: Configuration = .init(),
        action: (() -> Void)? = nil
    ) {
        self.icon = icon
        self.config = config
        self.action = action
    }
    
    // MARK: - View
    public var body: some View {
        Button {
            VibrationManager.vibration()
            if let action { action() }
        } label: {
            IconView(icon, color: config.iconColor)
                .padding(10)
                .background(config.bgColor, in: .rect(cornerRadius: .standard, style: .continuous))
        }
        .disabled(action == nil)
    }
}

// MARK: - Configuration
extension IconButtonView {
    
    public struct Configuration {
        public var iconColor: Color
        public var bgColor: Color
        
        public init(
            iconColor: Color = .Text.primary,
            bgColor: Color = .Background.bg100
        ) {
            self.iconColor = iconColor
            self.bgColor = bgColor
        }
    }
    
}

// MARK: - Preview
#Preview {
    IconButtonView(.iconLock) { }
}
