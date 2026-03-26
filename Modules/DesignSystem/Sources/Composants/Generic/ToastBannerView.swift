//
//  ToastBannerView.swift
//  DesignSystem
//
//  Created by Theo Sementa on 25/03/2026.
//

import SwiftUI
import Models
import ToastBannerKit

public struct ToastBannerView: View {

    // MARK: Dependencies
    let banner: ToastBannerUIModel

    // MARK: Init
    public init(banner: ToastBannerUIModel) {
        self.banner = banner
    }
    
    // MARK: Computed variables
    var style: ToastBannerStyle {
        return ToastBannerStyle(rawValue: banner.style.rawValue) ?? .error
    }

    // MARK: -
    public var body: some View {
        HStack(spacing: .small) {
            if let uiImage = banner.uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundStyle(style.foregroundColor)
                    .frame(width: .standard, height: .standard)
            }
            
            Text(banner.title)
                .font(.Body.smallRegular, color: style.foregroundColor)
                .lineLimit(1)
        }
        .padding(.small)
        .background(style.backgroundColor, in: .rect(cornerRadius: .small, style: .continuous))
    }
}

// MARK: - Preview
#Preview {
    VStack(spacing: .large) {
        ToastBannerView(banner: .errorAmountMandatory)
    }
}
