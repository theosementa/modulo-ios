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
        var detailledGoal: FinancialGoalDetailedDomain?
        private let provider: FinancialGoalProvider
        
        // MARK: Init
        init(
            id: String,
            provider: FinancialGoalProvider = MockFinancialGoalProvider.shared
        ) {
            self.provider = provider
            detailledGoal = provider.store.findOneDetailed(by: id)
        }
        
    }
    
}

extension FinancialGoalDetailsScreen.ViewModel {
    
    
    
}
