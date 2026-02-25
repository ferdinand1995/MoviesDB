//
//  View+Utility.swift
//  MoviesDB
//
//  Created by Ferdinand Tedjakusuma on 25/02/26.
//

import SwiftUI

extension View {
    func onEmpty<EmptyContent: View>(for condition: Bool,
                                     emptyContent: @escaping () -> EmptyContent) -> some View
    {
        modifier(UnavailableViewModifier(isNotAvailable: condition, emptyContent: emptyContent))
    }
}

struct UnavailableViewModifier<EmptyContent: View>: ViewModifier {
    var isNotAvailable: Bool
    let emptyContent: () -> EmptyContent

    func body(content: Content) -> some View {
        if isNotAvailable {
            emptyContent()
        } else {
            content
        }
    }
}
