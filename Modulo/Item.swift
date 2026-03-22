//
//  Item.swift
//  Modulo
//
//  Created by Theo Sementa on 22/03/2026.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
