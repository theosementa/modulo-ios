//
//  SwiftUIView.swift
//  DesignSystem
//
//  Created by Theo Sementa on 28/03/2026.
//

import SwiftUI
import Models
import Navigation

public struct CustomEmptyView: View {
    
    // MARK: Dependencies
    private let style: CustomEmptyStyle
    
    // MARK: Environments
    @Environment(Router<AppDestination>.self) private var router
    
    // MARK: Init
    public init(
        style: CustomEmptyStyle
    ) {
        self.style = style
    }
    
    // MARK: - View
    public var body: some View {
        VStack(spacing: .standard) {
            VStack(spacing: .tiny) {
                IconView(style.icon, size: 48)
                Text(style.title)
                    .font(.Body.largeSemiBold)
                Text(style.description)
                    .font(.Body.mediumRegular)
                    .multilineTextAlignment(.center)
            }
            if let buttonTitle = style.buttonTitle, let buttonIcon = style.buttonIcon {
                CapsuleButtonView(text: buttonTitle, icon: buttonIcon) { style.action(router: router) }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    CustomEmptyView(style: .noTargets)
}
