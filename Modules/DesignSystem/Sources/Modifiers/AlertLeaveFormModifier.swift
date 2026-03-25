//
//  AlertLeaveForm.swift
//  DesignSystem
//
//  Created by Theo Sementa on 25/03/2026.
//


import SwiftUI

struct AlertLeaveFormModifier: ViewModifier { // TODO: TBL
    
    // MARK: Dependencies
    @Binding var isPresented: Bool
    
    // MARK: Environments
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - View
    func body(content: Content) -> some View {
        content
            .alert(
                "confirmation_leave_form_title".localized,
                isPresented: $isPresented,
                actions: {
                    Button(
                        "confirmation_leave_form_destructive_button".localized,
                        role: .destructive,
                        action: { dismiss() }
                    )
                    Button(
                        "confirmation_leave_form_cancel_button".localized,
                        role: .cancel,
                        action: {}
                    )
                },
                message: {
                    Text("confirmation_leave_form_message".localized)
                }
            )
    }
}

// MARK: - Extension View
public extension View {
    func alertLeaveForm(isPresented: Binding<Bool>) -> some View {
        return modifier(AlertLeaveFormModifier(isPresented: isPresented))
    }
}
