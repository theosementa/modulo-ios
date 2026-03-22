//
//  SwiftDataContextManager.swift
//  POC_PhotoKit
//
//  Created by Theo Sementa on 13/05/2025.
//

import Foundation
import SwiftData
import Models

@MainActor
final class SwiftDataContextManager: ObservableObject {
    static let shared = SwiftDataContextManager()
    
    let container: ModelContainer
    var context: ModelContext
    
    private init() {
        do {
            container = try ModelContainer(for: FinancialGoalEntity.self, ContributionEntity.self)
            context = container.mainContext
        } catch {
            fatalError("Échec de l'initialisation du ModelContainer: \(error.localizedDescription)")
        }
    }
}
