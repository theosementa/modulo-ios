//
//  File.swift
//  DesignSystem
//
//  Created by Theo Sementa on 16/02/2026.
//

import Foundation
import SwiftUI
import Models

public extension View {
    
    func font(_ font: AppFont, color: Color? = nil) -> some View {
        let uiFont = UIFont(name: font.name, size: font.size) ?? UIFont.systemFont(ofSize: font.size)
        
        return self
            .font(Font(uiFont))
            .foregroundStyle(color ?? .Text.primary)
    }
    
    func fullWidth(_ alignment: Alignment = .center) -> some View {
        self.frame(maxWidth: .infinity, alignment: alignment)
    }
    
    func fullSize(_ alignment: Alignment = .center) -> some View {
        self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
    }
        
    @ViewBuilder
    func isDisplayed(_ isDisplayed: Bool) -> some View {
        if isDisplayed {
            self
        }
    }
    
    func overlay<T: View>(
        _ alignment: Alignment = .center,
        condition: Bool,
        @ViewBuilder content: () -> T
    ) -> some View {
        self.overlay(alignment: alignment) {
            if condition { content() }
        }
    }
    
    /// Only used for VStack
    func lockView() -> some View {
        GeometryReader { geometry in
            self
                .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .ignoresSafeArea(.keyboard)
    }
    
}
