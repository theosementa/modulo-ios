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
    
    @Attribute(.unique) public var id: UUID = UUID()
    
    public var name: String?
    
    public var amount: Double
    
    public var type: ContributionType
    
    public var date: Date
    
    public var financialGoal: FinancialGoalEntity?

    public init(
        name: String? = nil,
        amount: Double,
        type: ContributionType,
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
            type: type,
            date: date
        )
    }

}
