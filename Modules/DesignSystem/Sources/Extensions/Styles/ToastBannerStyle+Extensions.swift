//
//  File.swift
//  DesignSystem
//
//  Created by Theo Sementa on 25/03/2026.
//

import Foundation
import Models
import SwiftUI
import ToastBannerKit

extension ToastBannerStyle: @retroactive ToastBannerStyleProtocol { }

extension ToastBannerStyle {

    var foregroundColor: Color {
        switch self {
        case .neutral:
            return Color.Text.primaryReversed
        case .error:
            return Color.Error.e500
        case .success:
            return Color.Success.s500
        }
    }

    var backgroundColor: Color {
        switch self {
        case .neutral:
            return Color.Text.primary
        case .error:
            return Color.Error.e100
        case .success:
            return Color.Success.s100
        }
    }

}
