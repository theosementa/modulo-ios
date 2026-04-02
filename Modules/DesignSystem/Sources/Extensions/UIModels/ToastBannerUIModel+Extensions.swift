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
@MainActor
public extension ToastBannerUIModel {
    
    static let errorNameMandatory: ToastBannerUIModel = .init(
        title: "toast_banner_name_mandatory".localized,
        uiImage: UIImage(asset: .iconWarning),
        style: ToastBannerStyle.error
    )
    
    static let errorAmountMandatory: ToastBannerUIModel = .init(
        title: "toast_banner_amount_mandatory".localized,
        uiImage: UIImage(asset: .iconWarning),
        style: ToastBannerStyle.error
    )
    
}

// MARK: - Success
@MainActor
public extension ToastBannerUIModel {
 
    static let successGoalCreated: ToastBannerUIModel = .init(
        title: "toast_banner_goal_created".localized,
        uiImage: UIImage(asset: .iconCheckmarkRounded),
        style: ToastBannerStyle.success
    )
    
    static let successGoalUpdated: ToastBannerUIModel = .init(
        title: "toast_banner_goal_updated".localized,
        uiImage: UIImage(asset: .iconCheckmarkRounded),
        style: ToastBannerStyle.success
    )
    
    static let successGoalDeleted: ToastBannerUIModel = .init(
        title: "toast_banner_goal_deleted".localized,
        uiImage: UIImage(asset: .iconCheckmarkRounded),
        style: ToastBannerStyle.success
    )
    
    static let successContributionAdded: ToastBannerUIModel = .init(
        title: "toast_banner_contribution_added".localized,
        uiImage: UIImage(asset: .iconCheckmarkRounded),
        style: ToastBannerStyle.success
    )
    
    static let successContributionUpdated: ToastBannerUIModel = .init(
        title: "toast_banner_contribution_updated".localized,
        uiImage: UIImage(asset: .iconCheckmarkRounded),
        style: ToastBannerStyle.success
    )
    
    static let successContributionDeleted: ToastBannerUIModel = .init(
        title: "toast_banner_contribution_deleted".localized,
        uiImage: UIImage(asset: .iconCheckmarkRounded),
        style: ToastBannerStyle.success
    )
    
    static let successDeleteAllData: ToastBannerUIModel = .init(
        title: "toast_banner_delete_all".localized,
        uiImage: UIImage(asset: .iconCheckmarkRounded),
        style: ToastBannerStyle.success
    )
    
}
