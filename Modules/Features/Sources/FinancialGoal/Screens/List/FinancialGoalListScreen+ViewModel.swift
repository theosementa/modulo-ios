//
//  File.swift
//  Features
//
//  Created by Theo Sementa on 25/03/2026.
//

import Foundation
import Providers
import Models

extension FinancialGoalListScreen {
    
    @Observable @MainActor
    final class ViewModel {
        
        private let provider: FinancialGoalProvider
        
        init(provider: FinancialGoalProvider = MockFinancialGoalProvider.shared) {
            self.provider = provider
        }
        
    }
    
}

// MARK: - Computed variables
extension FinancialGoalListScreen.ViewModel {
    
    var financialGoals: [FinancialGoalDomain] {
        return provider.financialGoals(by: .maxAmount)
    }
    
}

extension FinancialGoalListScreen.ViewModel {
    
    func onAppearAction() {
        provider.store.fetchAll()
    }
    
}
