//
//  CoreUIFont.swift
//  
//
//  Created by Ferdinand on 18/11/22.
//

import UIKit.UIFont

extension UIFont {
    private static func customFont(name: String, size: CGFloat) -> UIFont {
        let font = UIFont(name: name, size: size)
        assert(font != nil, "Can't load font: \(name)")
        return font ?? UIFont.systemFont(ofSize: size)
    }

    static func mainFont(ofSize size: CGFloat) -> UIFont {
        return customFont(name: "Nunito-Regular", size: size)
    }

    static func boldMainFont(ofSize size: CGFloat) -> UIFont {
        return customFont(name: "Nunito-Bold", size: size)
    }

    static func semiBoldMainFont(ofSize size: CGFloat) -> UIFont {
        return customFont(name: "Nunito-SemiBold", size: size)
    }
}
