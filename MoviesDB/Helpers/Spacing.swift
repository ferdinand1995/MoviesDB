//
//
//  MoviesDB
//
//
//


import SwiftUI

/// Consistent spacing makes an interface more clear and easy to scan.
///
/// Our spacing is based on a 4-pixel grid.
///
public extension CGFloat {
    enum Spacing {
        /// Spacing: 1
        public static let xxxxxSmall: CGFloat = 1
        /// Spacing: 2
        public static let xxxxSmall: CGFloat = 2
        /// Spacing: 4
        public static let xxxSmall: CGFloat = 4
        /// Spacing: 8
        public static let xxSmall: CGFloat = 8
        /// Spacing: 12
        public static let xSmall: CGFloat = 12
        /// Spacing: 16
        public static let small: CGFloat = 16
        /// Spacing: 24
        public static let medium: CGFloat = 24
        /// Spacing: 32
        public static let large: CGFloat = 32
        /// Spacing: 48
        public static let xLarge: CGFloat = 48
        /// Spacing: 64
        public static let xxLarge: CGFloat = 64
        /// Spacing: 80
        public static let xxxLarge: CGFloat = 80
        /// Spacing: 96
        public static let xxxxLarge: CGFloat = 96
        /// Spacing: 120
        public static let xxxxxLarge: CGFloat = 120
    }
}
