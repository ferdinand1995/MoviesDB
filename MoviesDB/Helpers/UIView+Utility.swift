//
//  UIView+Utility.swift
//  MoviesDB
//
//  Created by Ferdinand on 20/11/22.
//

import UIKit

protocol LoadingIndicator: AnyObject {
    func showActivityIndicator()
    func hideActivityIndicator()
}

extension LoadingIndicator where Self: UIViewController {
    
    func showActivityIndicator() {
        self.view.makeToastActivity(.center)
    }
    
    func hideActivityIndicator() {
        self.view.hideToastActivity()
    }
}

extension UIView {

    private func addBlackGradientLayerInForeground(frame: CGRect, colors: [UIColor]) {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = colors.map { $0.cgColor }
        layer.addSublayer(gradient)
    }

    private func addBlackGradientLayerInBackground(frame: CGRect, colors: [UIColor]) {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = colors.map { $0.cgColor }
        layer.insertSublayer(gradient, at: 0)
    }

    func addBorderGradients() {
        addBlackGradientLayerInForeground(frame: CGRect(x: 0, y: 0, width: frame.maxX, height: 100), colors: [.brokenWhiteDarkMode, .clear])
        addBlackGradientLayerInForeground(frame: CGRect(x: 0, y: frame.maxY - 100, width: frame.maxX, height: 100), colors: [.clear, .brokenWhiteDarkMode])
    }
}
