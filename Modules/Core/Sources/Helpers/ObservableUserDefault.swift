//
//  ObservableUserDefault.swift
//  Core
//
//  Created by Theo Sementa on 04/04/2026.
//

import Foundation
import Observation

/// A property wrapper that bridges `UserDefaults` persistence with `@Observable` reactivity.
///
/// Usage:
/// ```swift
/// @Observable final class MyManager {
///     @ObservationIgnored @ObservableUserDefault("my_key")
///     var myValue: Bool = true
/// }
/// ```
@propertyWrapper
public struct ObservableUserDefault<Value> {

    private let key: String
    private let defaultValue: Value
    private let registrar = ObservationRegistrar()

    public init(wrappedValue defaultValue: Value, _ key: String) {
        self.key = key
        self.defaultValue = defaultValue
    }

    /// Never called directly — `_enclosingInstance` subscript takes over inside `@Observable` classes.
    public var wrappedValue: Value {
        get { fatalError("@ObservableUserDefault must be used within an @Observable class") }
        nonmutating set { fatalError("@ObservableUserDefault must be used within an @Observable class") } // swiftlint:disable:this unused_setter_value line_length
    }

    public static subscript<EnclosingType: Observable & AnyObject>(
        _enclosingInstance instance: EnclosingType,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<EnclosingType, Value>,
        storage storageKeyPath: ReferenceWritableKeyPath<EnclosingType, Self>
    ) -> Value {
        get {
            instance[keyPath: storageKeyPath].registrar.access(instance, keyPath: wrappedKeyPath)
            let storage = instance[keyPath: storageKeyPath]
            return UserDefaults.standard.object(forKey: storage.key) as? Value ?? storage.defaultValue
        }
        set {
            instance[keyPath: storageKeyPath].registrar.withMutation(of: instance, keyPath: wrappedKeyPath) {
                UserDefaults.standard.set(newValue, forKey: instance[keyPath: storageKeyPath].key)
            }
        }
    }

}
