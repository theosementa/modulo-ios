//
//  File.swift
//  Utilities
//
//  Created by Theo Sementa on 26/03/2026.
//

import Foundation

public extension Int {
    
    func toCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale.current
        return formatter.string(from: self as NSNumber) ?? ""
    }
    
}
