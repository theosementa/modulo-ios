//
//  VibrationManager.swift
//  Core
//
//  Created by Theo Sementa on 22/02/2026.
//

import Foundation
import UIKit

public final class VibrationManager { }

public extension VibrationManager {
    
    @MainActor
    static func vibration() {
        if UserDefaultManager.shared.isHapticFeebackEnabled {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        }
    }
    
}
