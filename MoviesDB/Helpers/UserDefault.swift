//
//  UserDefault.swift
//  MoviesDB
//
//  Created by Ferdinand Tedjakusuma on 25/02/26.
//

import Foundation

enum UserDefaultsKey {
    static let recent = "recent.search"
}

@propertyWrapper
struct UserDefault<T: Codable & Sendable>: @unchecked Sendable {
    private let key: String
    private let defaultValue: T
    private let container: UserDefaults

    init(
        key: String,
        defaultValue: T,
        container: UserDefaults = .standard
    ) {
        self.key = key
        self.defaultValue = defaultValue
        self.container = container
    }

    var wrappedValue: T {
        get {
            guard let data = container.data(forKey: key),
                  let value = try? PropertyListDecoder().decode(T.self, from: data)
            else { return defaultValue }

            return value
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                container.set(data, forKey: key)
            }
        }
    }
}
