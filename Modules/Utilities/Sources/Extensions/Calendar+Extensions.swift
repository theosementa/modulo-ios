//
//  File.swift
//  Utilities
//
//  Created by Theo Sementa on 31/03/2026.
//

import Foundation

public extension Calendar {
    
    func months(between startDate: Date, and endDate: Date?) -> Int? {
        guard let endDate else { return nil }
        
        let startDateComponents = Calendar.current.dateComponents([.year, .month], from: startDate)
        let endDateComponents = Calendar.current.dateComponents([.year, .month], from: endDate)
        let diffInDate = Calendar.current.dateComponents([.month], from: startDateComponents, to: endDateComponents).month ?? 0
        return diffInDate + 1 // +1 for include the current month
    }
    
    func days(between startDate: Date, and endDate: Date?) -> Int? {
        guard let endDate else { return nil }
        
        let days = Calendar.current.dateComponents([.day], from: startDate, to: endDate).day ?? 0
        return days
    }
    
}
