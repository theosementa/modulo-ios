//
//  NavigationButtonView.swift
//  Navigation
//
//  Created by Theo Sementa on 22/02/2026.
//

import SwiftUI
import PharosNav

public struct NavigationButtonView<Label: View>: View {

    // MARK: Dependencies
    let target: NavigationTarget<AppDestination>
    let onNavigate: (() -> Void)?
    let label: () -> Label

    // MARK: Init
    public init(
        target: NavigationTarget<AppDestination>,
        onNavigate: (() -> Void)? = nil,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.target = target
        self.onNavigate = onNavigate
        self.label = label
    }

    // MARK: - View
    public var body: some View {
        GenericNavigationButton(target: target, onNavigate: onNavigate, label: label)
    }

}
