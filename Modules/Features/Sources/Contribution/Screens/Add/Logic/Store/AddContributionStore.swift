//
//  AddContributionStore.swift
//  Features
//
//  Created by Theo Sementa on 06/06/2026.
//

import Foundation

protocol AddContributionStore {
    var state: AddContributionState { get }
    var sideEffects: AsyncStream<AddContributionSideEffect> { get }
    func send(_ intent: AddContributionIntent)
}
