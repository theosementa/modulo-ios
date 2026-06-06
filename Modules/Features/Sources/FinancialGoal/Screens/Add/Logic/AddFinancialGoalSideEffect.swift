//
//  AddFinancialGoalSideEffect.swift
//  Features
//
//  Created by Theo Sementa on 25/03/2026.
//

import ToastBannerKit

enum AddFinancialGoalSideEffect {
    case dismiss
    case showToast(ToastBannerUIModel)
    case presentLeaveAlert
}
