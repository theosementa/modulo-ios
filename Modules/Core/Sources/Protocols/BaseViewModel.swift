//
//  BaseViewModel.swift
//  Core
//
//  Created by Theo Sementa on 25/03/2026.
//

import Foundation
import Navigation

public protocol BaseViewModel { }

public extension BaseViewModel {
    
    @MainActor
    var router: Router<AppDestination>? {
        return AppRouterManager.shared.currentRouter
    }
    
}
