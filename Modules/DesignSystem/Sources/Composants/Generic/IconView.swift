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
        _ icon: ImageType,
        size: CGFloat = .large,
        color: Color = .Text.primary
    ) {
        self.icon = icon
        self.size = size
        self.color = color
    }
    
    // MARK: - View
    public var body: some View {
        Image(asset: icon)
            .resizable()
            .renderingMode(.template)
            .frame(width: size, height: size)
            .foregroundStyle(color)
    }
}

// MARK: - Preview
#Preview {
    IconView(.iconProfile)
}
