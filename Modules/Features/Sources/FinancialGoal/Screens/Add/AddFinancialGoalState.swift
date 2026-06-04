//
//  File.swift
//  Features
//
//  Created by Theo Sementa on 16/04/2026.
//

import Foundation

struct AddFinancialGoalState {
    var emoji: String = ""
    var name: String = ""
    var amount: Double = 0
    var startDate: Date = .now
    var endDate: Date? = nil
    
    var isLoading: Bool = false
    var errorMessage: String? = nil
}
