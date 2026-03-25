//
//  File.swift
//  DesignSystem
//
//  Created by Theo Sementa on 22/03/2026.
//

import Foundation
import SwiftUI

private extension Color {
    
    static func dynamicColor(light: UInt, dark: UInt) -> Color {
        let lightColor = Color(hex: light)
        let darkColor = Color(hex: dark)
        
        return Color(
            uiColor: UIColor { $0.userInterfaceStyle == .dark ? UIColor(darkColor) : UIColor(lightColor) }
        )
    }
    
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: alpha
        )
    }
    
}

public extension Color {
    
    struct Base {
        public static let white: Color = Color(hex: 0xFFFFFF)
        public static let black: Color = Color(hex: 0x000000)
    }
    
    struct Text {
        public static let primary: Color = dynamicColor(light: 0x000000, dark: 0xFFFFFF)
        public static let primaryReversed: Color = dynamicColor(light: 0xFFFFFF, dark: 0x000000)
        public static let secondary: Color = dynamicColor(light: 0x666666, dark: 0x999999)
        public static let tertiary: Color = dynamicColor(light: 0xB3B3B3, dark: 0x4D4D4D)
    }
    
    struct Background {
        public static let bg50: Color = dynamicColor(light: 0xF2F2F7, dark: 0x101010)
        public static let bg100: Color = dynamicColor(light: 0xFFFFFF, dark: 0x1C1C1E)
        public static let bg200: Color = dynamicColor(light: 0xE5E5EA, dark: 0x2C2C2E)
        public static let bg300: Color = dynamicColor(light: 0xD1D1D6, dark: 0x3A3A3C)
        public static let bg400: Color = dynamicColor(light: 0xC7C7CC, dark: 0x48484A)
        public static let bg500: Color = dynamicColor(light: 0xA9A9AB, dark: 0x636366)
        public static let bg600: Color = dynamicColor(light: 0x8E8E93, dark: 0x8E8E93)
    }
    
    struct Primary {
        public static let p500: Color = Color.blue
    }
    
    struct Success {
        public static let s500: Color = Color.green
        public static let s100: Color = Color.green.opacity(0.15)
    }
    
    struct Error {
        public static let e500: Color = Color.red
        public static let e100: Color = Color.red.opacity(0.15)
    }
    
}
