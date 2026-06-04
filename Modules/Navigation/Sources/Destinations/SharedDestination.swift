//
//  File.swift
//  Navigation
//
//  Created by Theo Sementa on 04/04/2026.
//

import Foundation
import PharosNav

public enum SharedDestination: DestinationItem {
    case sfSafari(url: URL)
    case onboarding
}
