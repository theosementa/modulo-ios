//
//  SwiftUIView.swift
//  DesignSystem
//
//  Created by Theo Sementa on 25/03/2026.
//

import SwiftUI

public enum NavigationBarStyle {
    case home, push(title: String)
    
    var title: String {
        switch self {
        case .home:
            "Objectifs"
        case .push(let title):
            title
        }
    }
}

public struct NavigationBarView: View {
    
    // MARK: Dependencies
    private let style: NavigationBarStyle
    private let rightAction: (() -> Void)?
    private let leftAction: (() -> Void)?
    
    // MARK: Init
    public init(
        style: NavigationBarStyle,
        rightAction: (() -> Void)? = nil,
        leftAction: (() -> Void)? = nil
    ) {
        self.style = style
        self.rightAction = rightAction
        self.leftAction = leftAction
    }
    
    // MARK: - View
    public var body: some View {
        Group {
            switch style {
            case .home:
                HStack(alignment: .bottom, spacing: 8) {
                    Text(style.title)
                        .font(.Title.largeSemiBold)
                        .fullWidth(.leading)
                    
                    IconButtonView(.iconProfile) {
                        if let rightAction { rightAction() }
                    }
                }
            case .push:
                HStack(spacing: 8) {
                    IconButtonView(.iconChevronLeft) {
                        if let leftAction { leftAction() }
                    }
                    
                    Text(style.title)
                        .font(.Body.largeMedium)
                        .fullWidth()
                    
                    IconButtonView(.iconPencil) {
                        if let rightAction { rightAction() }
                    }
                    .opacity(rightAction == nil ? 0 : 1)
                }
            }
        }
        .padding(.standard)
        .background(Color.Background.bg50)
    }
}

// MARK: - Preview
#Preview {
    NavigationBarView(style: .home)
}
