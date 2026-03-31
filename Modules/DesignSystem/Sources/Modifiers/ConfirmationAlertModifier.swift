//
//  AlertLeaveForm.swift
//  DesignSystem
//
//  Created by Theo Sementa on 25/03/2026.
//

import SwiftUI
import Models

struct ConfirmationAlertModifier: ViewModifier {
    
    // MARK: Dependencies
    let style: ConfirmationAlertType
    @Binding var isPresented: Bool
    let destructiveAction: () -> Void
    
    // MARK: Environments
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - View
    func body(content: Content) -> some View {
        content
            .alert(
                style.title,
                isPresented: $isPresented,
                actions: {
                    Button(
                        style.actionButton,
                        role: .destructive,
                        action: { destructiveAction() }
                    )
                    Button(
                        style.cancelButton,
                        role: .cancel,
                        action: {}
                    )
                },
                message: {
                    Text(style.message)
                }
            )
    }
}

// MARK: - Extension View
public extension View {
    func confirmationAlert(_ style: ConfirmationAlertType, isPresented: Binding<Bool>, destructiveAction: @escaping () -> Void) -> some View {
        return modifier(ConfirmationAlertModifier(style: style, isPresented: isPresented, destructiveAction: destructiveAction))
    }
}
