//
//  UserCurrency.swift
//  Core
//
//  Created by Theo Sementa on 25/03/2026.
//

import Foundation

public final class UserCurrency {
    public static let symbol = Locale(identifier: Locale.current.identifier).currencySymbol ?? "x"
    public static let name = Locale.autoupdatingCurrent.localizedString(forCurrencyCode: Locale.current.currency?.identifier ?? "x") ?? "x"
}
