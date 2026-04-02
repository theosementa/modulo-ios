//
//  File.swift
//  Features
//
//  Created by Theo Sementa on 25/03/2026.
//

import Foundation
import Core
import Models
import Stores
import ToastBannerKit

extension AddFinancialGoalScreen {
    
    @Observable @MainActor
    final class ViewModel: BaseViewModel {
        
        // MARK: Dependencies
        var goalId: String?
        private let store: FinancialGoalStore
        var toastBannerService: ToastBannerService
        
        // MARK: States
        var emoji: String = "🚗"
        var name: String = ""
        var amount: String = "0"
        var startDate: Date? = .now
        var endDate: Date?
        
        // MARK: UI Variables
        var namePlaceholder: String = ""
        var isAlertLeavePresented: Bool = false
        var showEmojiPicker: Bool = false
        
        // MARK: Init
        init(
            goalId: String? = nil,
            store: FinancialGoalStore = DefaultFinancialGoalStore.shared,
            toastBannerService: ToastBannerService = .shared
        ) {
            self.store = store
            self.toastBannerService = toastBannerService
            self.namePlaceholder = randomPlaceholder()
            self.goalId = goalId
            if let goalId, let financialGoal = store.findOne(by: goalId) {
                self.emoji = financialGoal.emoji
                self.name = financialGoal.name
                self.amount = financialGoal.goalAmount.toString()
                self.startDate = financialGoal.startDate
                self.endDate = financialGoal.endDate
            }
        }
    }
    
}

// MARK: - Computed variables
extension AddFinancialGoalScreen.ViewModel {
    
    var isModelInCreation: Bool {
        return endDate.isNotNil
        || name.isReallyEmpty == false
        || amount.toDouble() != 0
    }
    
    var isEditing: Bool { goalId != nil }

}

// MARK: - Public functions
extension AddFinancialGoalScreen.ViewModel {
    
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
private extension AddFinancialGoalScreen.ViewModel {
    
    func checkDatas() throws {
        if name.isReallyEmpty {
            toastBannerService.send(.errorNameMandatory)
            throw AddFinancialGoalError.missingName
        }
        
        if amount.toDouble() == 0 {
            toastBannerService.send(.errorAmountMandatory)
            throw AddFinancialGoalError.missingAmount
        }
    }
    
    func create() {
        let domain = FinancialGoalDomain(
            id: "0",
            name: name,
            emoji: emoji,
            goalAmount: amount.toDouble(),
            startDate: startDate ?? .now,
            endDate: endDate
        )
        store.create(goal: domain)
        router?.dismiss()
        toastBannerService.send(.successGoalCreated, delay: AppConstant.Animation.toastDelayAfterCloseSheet)
    }
    
    func update() {
        guard let goalId else { return }
        let domain = FinancialGoalDomain(
            id: goalId,
            name: name,
            emoji: emoji,
            goalAmount: amount.toDouble(),
            startDate: startDate ?? .now,
            endDate: endDate
        )
        store.update(goal: domain)
        router?.dismiss()
        toastBannerService.send(.successGoalUpdated, delay: AppConstant.Animation.toastDelayAfterCloseSheet)
    }
    
    func randomPlaceholder() -> String {
        let availablePlaceholders: [String] = [
            "add_financial_goal_field_name_placeholder_one",
            "add_financial_goal_field_name_placeholder_two",
            "add_financial_goal_field_name_placeholder_three",
            "add_financial_goal_field_name_placeholder_four",
            "add_financial_goal_field_name_placeholder_five"
        ]
        return availablePlaceholders.randomElement() ?? ""
    }
    
}
