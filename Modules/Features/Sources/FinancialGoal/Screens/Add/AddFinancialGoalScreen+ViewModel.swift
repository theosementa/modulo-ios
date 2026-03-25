//
//  File.swift
//  Features
//
//  Created by Theo Sementa on 25/03/2026.
//

import Foundation
import Core
import Models

extension AddFinancialGoalScreen {
    
    @Observable @MainActor
    final class ViewModel: BaseViewModel {
        
        // MARK: Dependencies
        var financialGoal: FinancialGoalDomain?
        
        // MARK: States
        var name: String = ""
        var amount: String = "0"
        var startDate: Date? = .now
        var endDate: Date?
        
        // MARK: UI Variables
        var namePlaceholder: String = ""
        var isAlertLeavePresented: Bool = false
    }
    
}

// MARK: - Computed variables
extension AddFinancialGoalScreen.ViewModel {
    
    var isModelInCreation: Bool {
        return endDate.isNotNil
        || name.isReallyEmpty == false
        || amount.toDouble() != 0
    }
    
    var isEditing: Bool { financialGoal != nil }

}

// MARK: - Public functions
extension AddFinancialGoalScreen.ViewModel {
    
    func validationAction() async {
        do {
            try checkDatas()
            if financialGoal == nil {
//                await createTransaction(dismiss: dismiss)
            } else {
//                await updateTransaction(dismiss: dismiss)
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
        if amount.isReallyEmpty || amount.toDouble() == 0 {
//            toastBannerService.send(.errorAmountMandatory)
//            throw NetworkError.fieldIsIncorrectlyFilled
        }
    }
    
}
