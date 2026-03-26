//
//  File.swift
//  Models
//
//  Created by Theo Sementa on 26/03/2026.
//

import Foundation

public struct ContributionUIModel: Identifiable {
    public let id: String
    public let name: String
    public let amountFormatted: String
    public let type: ContributionType
    public let dateFormatted: String

    public init(
        id: String,
        name: String,
        amountFormatted: String,
        type: ContributionType,
        dateFormatted: String
    ) {
        self.id = id
        self.name = name
        self.amountFormatted = amountFormatted
        self.type = type
        self.dateFormatted = dateFormatted
    }
}
