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
        private let store: FinancialGoalStore
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
            store: FinancialGoalStore = DefaultFinancialGoalStore.shared,
            toastBannerService: ToastBannerService = .shared
        ) {
            self.goalId = goalId
            self.store = store
            self.toastBannerService = toastBannerService
        }

    }

}

// MARK: - Computed
extension AddContributionScreen.ViewModel {

    var isModelInCreation: Bool {
        amount.toDouble() != 0 || name.isReallyEmpty == false
    }

}

// MARK: - Public functions
extension AddContributionScreen.ViewModel {

    func validationAction() async {
        do {
            try checkDatas()
            save()
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

    func save() {
        store.addContribution(
            to: goalId,
            name: name.isReallyEmpty ? nil : name,
            amount: amount.toDouble(),
            type: type,
            date: date ?? .now
        )
        router?.dismiss()
    }

}
