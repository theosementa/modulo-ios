//
//  File.swift
//  DesignSystem
//
//  Created by Theo Sementa on 22/02/2026.
//

import Models
import ToastBannerKit
import UIKit

// MARK: - Errors
public extension ToastBannerUIModel {
    
    @MainActor
    static let errorNameMandatory: ToastBannerUIModel = .init(
        title: "toast_banner_name_mandatory".localized,
        uiImage: UIImage(asset: .iconWarning),
        style: ToastBannerStyle.error
    )
    
    @MainActor
    static let errorAmountMandatory: ToastBannerUIModel = .init(
        title: "toast_banner_amount_mandatory".localized,
        uiImage: UIImage(asset: .iconWarning),
        style: ToastBannerStyle.error
    )
    
}
