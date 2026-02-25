//
//  UserDefaultsObserver.swift
//  MoviesDB
//
//  Created by Ferdinand Tedjakusuma on 25/02/26.
//

import Combine
import Foundation

class UserDefaultsObserver: NSObject {
    private let observedKeys: [String]

    var onValueChanged: ((String, Any?) -> Void)?

    init(keys: [String]) {
        self.observedKeys = keys
        super.init()

        for key in keys {
            UserDefaults.standard.addObserver(
                self,
                forKeyPath: key,
                options: [.old, .new],
                context: nil
            )
        }
    }

    deinit {
        for key in observedKeys {
            UserDefaults.standard.removeObserver(self, forKeyPath: key)
        }
    }

    override func observeValue(
        forKeyPath keyPath: String?,
        of object: Any?,
        change: [NSKeyValueChangeKey: Any]?,
        context: UnsafeMutableRawPointer?
    ) {
        guard let key = keyPath else { return }
        let newValue = change?[.newKey]
        onValueChanged?(key, newValue)
    }
}
