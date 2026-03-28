//
//  File.swift
//  Utilities
//
//  Created by Theo Sementa on 27/03/2026.
//

import Foundation
import UIKit

public extension UIDevice {
    
    static func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
