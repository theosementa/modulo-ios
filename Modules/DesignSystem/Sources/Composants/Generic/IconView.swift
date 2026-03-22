//
//  SwiftUIView.swift
//  DesignSystem
//
//  Created by Theo Sementa on 22/03/2026.
//

import SwiftUI
import Models

public struct IconView: View {
    
    // MARK: Dependencies
    private let icon: ImageType
    private let size: CGFloat
    private let color: Color
    
    // MARK: Init
    public init(
        icon: ImageType,
        size: CGFloat = 16,
        color: Color = .primary
    ) {
        self.icon = icon
        self.size = size
        self.color = color
    }
    
    // MARK: - View
    public var body: some View {
        Image(systemName: icon.rawValue)
            .font(.system(size: size))
            .foregroundStyle(color)
    }
}

// MARK: - Preview
#Preview {
    IconView(icon: .iconProfile)
}
