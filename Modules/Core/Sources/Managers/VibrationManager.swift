//
//  VibrationManager.swift
//  Core
//
//  Created by Theo Sementa on 22/02/2026.
//

import Foundation
import UIKit
// import Preferences

public final class VibrationManager { }

public extension VibrationManager {
    
    @MainActor
    static func vibration() {
//        if PreferencesGeneral.shared.hapticFeedback {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
//        }
    }
    
}
