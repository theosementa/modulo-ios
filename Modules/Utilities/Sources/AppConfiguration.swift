//
//  AppConfiguration.swift
//  Utilities
//
//  Created by Theo Sementa on 07/04/2026.
//

import Foundation

public struct AppConfiguration {
    
    public enum AppEnvironment: Sendable {
        case prod
        case dev
        case mock
    }
    
    nonisolated(unsafe) private static var _environment: AppEnvironment = .dev
    
    public static var environment: AppEnvironment {
        get { _environment }
        set { _environment = newValue }
    }
    
    public static func setEnvironment(_ environment: AppEnvironment) {
        AppConfiguration._environment = environment
    }
    
}
