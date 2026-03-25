//
//  File.swift
//  DesignSystem
//
//  Created by Theo Sementa on 16/02/2026.
//

import Foundation
import SwiftUI

@MainActor
public struct AppFont {
    let name: String
    let size: CGFloat
}

public let fontRegular: String = "Outfit-Regular"
public let fontMedium: String = "Outfit-Medium"
public let fontSemiBold: String = "Outfit-SemiBold"
public let fontBold: String = "Outfit-Bold"

public extension AppFont {
    
    static func custom(name: String, size: CGFloat) -> AppFont {
        return AppFont(name: name, size: size)
    }
    
    struct Display {
        
        /// `This font is in "Bold 40" style`
        public static let extraLargeBold: AppFont = AppFont(name: fontBold, size: 40)
        
        /// `This font is in "SemiBold 40" style`
        public static let extraLargeSemiBold: AppFont = AppFont(name: fontSemiBold, size: 40)
        
        /// `This font is in "Bold 36" style`
        public static let largeBold: AppFont = AppFont(name: fontBold, size: 36)
        
        /// `This font is in "Bold 32" style`
        public static let mediumBold: AppFont = AppFont(name: fontBold, size: 32)
        
        /// `This font is in "SemiBold 28" style`
        public static let smallSemiBold: AppFont = AppFont(name: fontSemiBold, size: 28)
        
    }
    
    struct Title {
        
        /// `This font is in "SemiBold 24" style`
        public static let largeSemiBold: AppFont = AppFont(name: fontSemiBold, size: 24)
        
        /// `This font is in "Medium 20" style`
        public static let mediumMedium: AppFont = AppFont(name: fontMedium, size: 20)
        
    }
    
    struct Body {
        
        /// `This font is in "SemiBold 18" style`
        public static let largeSemiBold: AppFont = AppFont(name: fontSemiBold, size: 18)
        
        /// `This font is in "Medium 18" style`
        public static let largeMedium: AppFont = AppFont(name: fontMedium, size: 18)
        
        /// `This font is in "SemiBold 16" style`
        public static let mediumSemiBold: AppFont = AppFont(name: fontSemiBold, size: 16)
        
        /// `This font is in "Medium 16" style`
        public static let mediumMedium: AppFont = AppFont(name: fontMedium, size: 16)
        
        /// `This font is in "Regular 16" style`
        public static let mediumRegular: AppFont = AppFont(name: fontRegular, size: 16)
        
        /// `This font is in "Regular 14" style`
        public static let smallRegular: AppFont = AppFont(name: fontRegular, size: 14)
        
    }
    
    struct Label {
        
        /// `This font is in "Medium 12" style`
        public static let largeMedium: AppFont = AppFont(name: fontMedium, size: 12)
        
        /// `This font is in "Regular 12" style`
        public static let largeRegular: AppFont = AppFont(name: fontRegular, size: 12)
        
        /// `This font is in "Medium 10" style`
        public static let mediumMedium: AppFont = AppFont(name: fontMedium, size: 10)
        
        /// `This font is in "Bold 8" style`
        public static let smallBold: AppFont = AppFont(name: fontBold, size: 8)
        
    }
    
}
