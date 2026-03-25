//
//  File.swift
//  Utilities
//
//  Created by Theo Sementa on 17/02/2026.
//

import Foundation

public extension Double {
    
    func toString(minDigits: Int = 0, maxDigits: Int = 2) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = minDigits
        formatter.maximumFractionDigits = maxDigits
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
    
    func toCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale.current
        return formatter.string(from: self as NSNumber) ?? ""
    }
    
}
