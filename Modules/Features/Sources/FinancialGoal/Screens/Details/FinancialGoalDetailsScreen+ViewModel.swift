//
//  File.swift
//  Features
//
//  Created by Theo Sementa on 26/03/2026.
//

import Foundation
import Models
import Providers
import Core

extension FinancialGoalDetailsScreen {
    
    @Observable @MainActor
    final class ViewModel: BaseViewModel {
        
        // MARK: Dependencies
        var goalId: String
        
        private let provider: FinancialGoalProvider
        
        // MARK: Init
        init(
            id: String,
            provider: FinancialGoalProvider = DefaultFinancialGoalProvider.shared
        ) {
            self.goalId = id
            self.provider = provider
        }
        
    }
    
}

extension FinancialGoalDetailsScreen.ViewModel {
    
    var detailledGoal: FinancialGoalDetailedDomain? {
        return provider.store.findOneDetailed(by: goalId)
    }
    
    var isChartDisplayed: Bool {
        return detailledGoal?.contributions.isEmpty == false
    }
    
}
