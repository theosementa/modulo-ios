//
//  File.swift
//  DesignSystem
//
//  Created by Theo Sementa on 16/02/2026.
//

import Foundation
import Models
import SwiftUI

public extension Image {
    
    init(asset: ImageType) {
        self.init(asset.rawValue, bundle: .module)
    }
    
}
