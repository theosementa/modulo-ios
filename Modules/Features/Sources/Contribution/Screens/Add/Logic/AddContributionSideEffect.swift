//
//  AddContributionSideEffect.swift
//  Features
//
//  Created by Theo Sementa on 06/06/2026.
//

import ToastBannerKit

enum AddContributionSideEffect: Equatable {
    case dismiss
    case showToast(ToastBannerUIModel)
    case presentLeaveAlert
}
