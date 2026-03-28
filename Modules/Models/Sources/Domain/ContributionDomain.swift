//
//  ContributionDomain.swift
//  Models
//
//  Created by Theo Sementa on 26/03/2026.
//

import Foundation
import Utilities

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

public extension ContributionDomain {
    
    func toEntity(goal: FinancialGoalEntity) -> ContributionEntity {
        return .init(
            name: name,
            amount: amount,
            type: type,
            date: date,
            financialGoal: goal
        )
    }
    
    func toUIModel() -> ContributionUIModel {
        return .init(
            id: id,
            name: name ?? (type == .add ? "contribution_money_added" : "contribution_money_withdrawn").localized,
            amountFormatted: (type == .add ? "+ " : "- ") + amount.toCurrency(),
            type: type,
            dateFormatted: date.formatted(date: .numeric, time: .omitted)
        )
    }
    
}

// MARK: - Mocks
@MainActor
public extension ContributionDomain {

    /// Retourne des contributions fictives propres à chaque goal mock.
    static func mocks(for goalId: String) -> [ContributionDomain] {
        let cal = Calendar.current
        func date(_ months: Int, _ days: Int = 0) -> Date {
            var d = cal.date(byAdding: .month, value: months, to: .now) ?? .now
            d = cal.date(byAdding: .day, value: days, to: d) ?? d
            return d
        }

        switch goalId {

        // Vacances Japon — currentAmount: 600 (400 add + 200 add - 50 remove + 50 add ce mois)
        case "mock-1":
            return [
                .init(id: "m1-c1", name: "Virement", amount: 200, type: .add, date: date(-3)),
                .init(id: "m1-c2", name: "Prime été", amount: 200, type: .add, date: date(-2)),
                .init(id: "m1-c3", name: "Retrait exceptionnel", amount: 50, type: .remove, date: date(-1)),
                .init(id: "m1-c4", name: "Virement", amount: 200, type: .add, date: date(-1, 15)),
                .init(id: "m1-c5", name: "Virement", amount: 50, type: .add, date: date(0)),
            ]

        // MacBook Pro — currentAmount: 1200 (pas de contribution ce mois-ci)
        case "mock-2":
            return [
                .init(id: "m2-c1", name: "Virement", amount: 300, type: .add, date: date(-4)),
                .init(id: "m2-c2", name: "Virement", amount: 300, type: .add, date: date(-3)),
                .init(id: "m2-c3", name: "Virement", amount: 300, type: .add, date: date(-2)),
                .init(id: "m2-c4", name: "Virement", amount: 350, type: .add, date: date(-1)),
                .init(id: "m2-c5", name: "Achat accessoire", amount: 50, type: .remove, date: date(-1, 10)),
            ]

        // Fonds d'urgence — currentAmount: 2500 (gros virement ce mois)
        case "mock-3":
            return [
                .init(id: "m3-c1", name: "Virement", amount: 400, type: .add, date: date(-6)),
                .init(id: "m3-c2", name: "Virement", amount: 400, type: .add, date: date(-5)),
                .init(id: "m3-c3", name: "Retrait urgence", amount: 100, type: .remove, date: date(-4)),
                .init(id: "m3-c4", name: "Virement", amount: 400, type: .add, date: date(-3)),
                .init(id: "m3-c5", name: "Virement", amount: 400, type: .add, date: date(-2)),
                .init(id: "m3-c6", name: "Virement", amount: 400, type: .add, date: date(-1)),
                .init(id: "m3-c7", name: "Virement", amount: 600, type: .add, date: date(0)),
            ]

        // Voiture — currentAmount: 3000 (retrait ce mois)
        case "mock-4":
            return [
                .init(id: "m4-c1", name: "Virement", amount: 600, type: .add, date: date(-5)),
                .init(id: "m4-c2", name: "Virement", amount: 600, type: .add, date: date(-4)),
                .init(id: "m4-c3", name: "Virement", amount: 600, type: .add, date: date(-3)),
                .init(id: "m4-c4", name: "Virement", amount: 600, type: .add, date: date(-2)),
                .init(id: "m4-c5", name: "Virement", amount: 700, type: .add, date: date(-1)),
                .init(id: "m4-c6", name: "Retrait réparation", amount: 100, type: .remove, date: date(0)),
            ]

        default:
            return []
        }
    }

}
