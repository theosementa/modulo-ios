//
//  ContributionDomain.swift
//  Models
//
//  Created by Theo Sementa on 26/03/2026.
//

import Foundation

public struct ContributionDomain: Identifiable {
    public let id: String
    public let name: String?
    public let amount: Double
    public let type: ContributionType
    public let date: Date

    public init(
        id: String,
        name: String? = nil,
        amount: Double,
        type: ContributionType,
        date: Date
    ) {
        self.id = id
        self.name = name
        self.amount = amount
        self.type = type
        self.date = date
    }
}

// MARK: - Mocks
@MainActor
public extension ContributionDomain {

    static let mocks: [ContributionDomain] = [
        .init(
            id: "c-1",
            name: "Salaire janvier",
            amount: 200,
            type: .add,
            date: Calendar.current.date(byAdding: .month, value: -3, to: .now) ?? .now
        ),
        .init(
            id: "c-2",
            amount: 150,
            type: .add,
            date: Calendar.current.date(byAdding: .month, value: -2, to: .now) ?? .now
        ),
        .init(
            id: "c-3",
            name: "Retrait exceptionnel",
            amount: 50,
            type: .remove,
            date: Calendar.current.date(byAdding: .month, value: -1, to: .now) ?? .now
        ),
        .init(
            id: "c-4",
            name: "Prime",
            amount: 300,
            type: .add,
            date: .now
        ),
    ]

}
