//
//  AddContributionScreen+ViewModel.swift
//  Features
//
//  Created by Theo Sementa on 26/03/2026.
//

import Foundation
import Core
import Models
import Stores
import ToastBannerKit

extension AddContributionScreen {

    @Observable @MainActor
    final class ViewModel: BaseViewModel {

        // MARK: Dependencies
        private let goalId: String
        private let contributionId: String?
        private let contributionStore: ContributionStore
        private let financialGoalStore: FinancialGoalStore
        var toastBannerService: ToastBannerService

        // MARK: States
        var name: String = ""
        var amount: String = "0"
        var date: Date? = .now
        var type: ContributionType = .add

        // MARK: UI Variables
        var isAlertLeavePresented: Bool = false

        // MARK: Init
        init(
            goalId: String,
            contributionId: String? = nil,
            contributionStore: ContributionStore = DefaultContributionStore.shared,
            financialGoalStore: FinancialGoalStore = DefaultFinancialGoalStore.shared,
            toastBannerService: ToastBannerService = .shared
        ) {
            self.goalId = goalId
            self.contributionId = contributionId
            self.contributionStore = contributionStore
            self.financialGoalStore = financialGoalStore
            self.toastBannerService = toastBannerService
            if let contributionId, let contribution = contributionStore.findOneBy(contributionId) {
                self.name = contribution.name ?? ""
                self.amount = contribution.amount.toString()
                self.date = contribution.date
                self.type = contribution.type
            }
        }

    }

}

// MARK: - Computed
extension AddContributionScreen.ViewModel {

    var isModelInCreation: Bool {
        amount.toDouble() != 0 || name.isReallyEmpty == false
    }
    
    var isEditing: Bool {
        return contributionId != nil
    }

}

// MARK: - Public functions
extension AddContributionScreen.ViewModel {

    func validationAction() async {
        do {
            try checkDatas()
            if isEditing {
                update()
            } else {
                create()
            }
        } catch { }
    }

    func dismissAction() {
        if isModelInCreation {
            isAlertLeavePresented.toggle()
        } else {
            router?.dismiss()
        }
    }

}

// MARK: - Private functions
private extension AddContributionScreen.ViewModel {

    func checkDatas() throws {
        if amount.toDouble() == 0 {
            toastBannerService.send(.errorAmountMandatory)
            throw AddContributionError.missingAmount
        }
    }

    func create() {
        let contribution = ContributionDomain(
            id: "0",
            goalId: goalId,
            name: name.isReallyEmpty ? nil : name,
            amount: amount.toDouble(),
            type: type,
            date: date ?? .now
        )
        
        contributionStore.create(contribution: contribution)
        router?.dismiss()
        toastBannerService.send(.successContributionAdded, delay: AppConstant.Animation.toastDelayAfterCloseSheet)
    }
    
    func update() {
        guard let contributionId else { return }
        
        let contribution = ContributionDomain(
            id: contributionId,
            goalId: goalId,
            name: name.isReallyEmpty ? nil : name,
            amount: amount.toDouble(),
            type: type,
            date: date ?? .now
        )
        
        contributionStore.update(contribution: contribution)
        router?.dismiss()
        toastBannerService.send(.successContributionUpdated, delay: AppConstant.Animation.toastDelayAfterCloseSheet)
    }

}
