//
//  File.swift
//  Models
//
//  Created by Theo Sementa on 22/03/2026.
//

import Foundation
import SwiftData

@Model
public final class ContributionEntity {
    
    public var id: UUID = UUID()

    public var name: String?

    public var amount: Double = 0

    public var type: String = ContributionType.add.rawValue

    public var date: Date = Date.now
    
    public var financialGoal: FinancialGoalEntity?

    public init(
        name: String? = nil,
        amount: Double,
        type: String,
        date: Date,
        financialGoal: FinancialGoalEntity
    ) {
        self.name = name
        self.amount = amount
        self.type = type
        self.date = date
        self.financialGoal = financialGoal
    }
}

public extension ContributionEntity {

    func toDomain() -> ContributionDomain {
        return .init(
            id: id.uuidString,
            name: name,
            amount: amount,
            type: ContributionType(rawValue: type) ?? .add,
            date: date
        )
    }

}
