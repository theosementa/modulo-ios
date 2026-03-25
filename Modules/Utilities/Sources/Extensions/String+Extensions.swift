//
//  File.swift
//  Utilities
//
//  Created by Theo Sementa on 25/03/2026.
//

import Foundation

public extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    var isReallyEmpty: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func toDouble() -> Double {
        let newVariable = NumberFormatter()
        newVariable.numberStyle = .decimal
        newVariable.locale = Locale.current
        return newVariable.number(from: self) as? Double ?? Double(self) ?? 0
    }
    
}
