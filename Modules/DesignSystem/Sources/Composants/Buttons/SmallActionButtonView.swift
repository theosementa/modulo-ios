//
//  SmallActionButtonView.swift
//  DesignSystem
//
//  Created by Theo Sementa on 25/03/2026.
//

import SwiftUI
import Models

public struct SmallActionButtonView: View {
    
    // MARK: Dependencies
    let style: SmallActionButtonStyle
    let icon: ImageType
    let text: String
    var config: Configuration
    var action: (() async -> Void)?
    
    // MARK: Init
    public init(
        style: SmallActionButtonStyle = .classic,
        icon: ImageType,
        text: String,
        config: Configuration = .init(),
        action: (() async -> Void)? = nil
    ) {
        self.style = style
        self.icon = icon
        self.text = text
        self.config = config
        self.action = action
    }
    
    // MARK: - View
    public var body: some View {
        Button {
            Task {
                if let action {
                    await action()
                }
            }
        } label: {
            HStack(spacing: .small) {
                IconView(icon, size: .mediumLarge, color: style.foregroundColor)
                Text(text)
                    .font(.Body.mediumRegular, color: style.foregroundColor)
            }
            .padding(.horizontal, .standard)
            .padding(.vertical, .medium)
            .frame(maxWidth: config.isFullWidth ? .infinity : nil, alignment: config.isFullWidth ? .leading : .center)
            .background(style.backgroundColor, in: .rect(cornerRadius: .medium, style: .continuous))
        }
        .disabled(action == nil)
    }
}

// MARK: - Utils
public enum SmallActionButtonStyle: Equatable {
    case classic
    case noValue
    case withValue(bgColor: Color)
    
    var foregroundColor: Color {
        switch self {
        case .classic:
            return .Text.primary
        case .noValue:
            return .Text.secondary
        case .withValue:
            return .Base.white
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .classic, .noValue:
            return .Background.bg100
        case .withValue(let bgColor):
            return bgColor
        }
    }
    
    var strokeColor: Color? {
        switch self {
        case .classic, .noValue:
            return .Background.bg200
        case .withValue:
            return nil
        }
    }
    
}

extension SmallActionButtonView {
    
    public struct Configuration {
        public var isFullWidth: Bool
        
        public init(isFullWidth: Bool = false) {
            self.isFullWidth = isFullWidth
        }
    }
    
}

// MARK: - Preview
#Preview {
    VStack(spacing: .medium) {
        SmallActionButtonView(
            style: .classic,
            icon: .iconFile,
            text: "Hello World!",
            action: { }
        )
        
        SmallActionButtonView(
            style: .noValue,
            icon: .iconFile,
            text: "Hello World!",
            action: { }
        )
        
        SmallActionButtonView(
            style: .withValue(bgColor: Color.Primary.p500),
            icon: .iconFile,
            text: "Hello World!",
            action: { }
        )
    }
    .padding(.large)
}
