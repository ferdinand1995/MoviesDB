//
//  UIColor+Utility.swift
//
//
//  Created by Ferdinand on 18/11/22.
//  Copyright © 2021 siloamhospital. All rights reserved.
//

import UIKit.UIColor

extension UIColor {

    static func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else { return light }
        return UIColor { $0.userInterfaceStyle == .dark ? dark : light }
    }

    class func hexStringToUIColor(_ hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) { cString = String(cString.dropFirst()) }
        if ((cString.count) != 6) { return UIColor.gray }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    /** #F8F7F3 */
    class var BROKEN_WHITE: UIColor {
        return self.hexStringToUIColor("#F8F7F3")
    }
    /** #181A18 */
    class var SOFT_BLACK: UIColor {
        return self.hexStringToUIColor("#181A18")
    }
    
    /** #a9a9a9 */
    class var DARK_GRAY: UIColor {
        return self.hexStringToUIColor("#a9a9a9")
    }
    
    /** #565656 */
    class var INVERTED_DARK_GRAY: UIColor {
        return self.hexStringToUIColor("#565656")
    }
    
    static let brokenWhiteDarkMode: UIColor = dynamicColor(light: UIColor.BROKEN_WHITE, dark: UIColor.SOFT_BLACK)
    
    static let softBlackDarkMode: UIColor = dynamicColor(light: UIColor.SOFT_BLACK, dark: UIColor.BROKEN_WHITE)
    
    static let darkGrayDarkMode: UIColor = dynamicColor(light: UIColor.DARK_GRAY, dark: UIColor.INVERTED_DARK_GRAY)

}
