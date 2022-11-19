//
//  UIViewController+Utility.swift
//
//
//  Created by Ferdinand on 18/11/22.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func add(_ child: UIViewController, frame: CGRect? = nil) {
        addChild(child)
        if let frame = frame {
            child.view.frame = frame
        }
        self.view.addSubview(child.view)
        child.view.alpha = 0
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            child.view.alpha = 1
        } completion: { _ in
            child.didMove(toParent: self)
        }
    }

    func remove() {
        guard parent != nil else { return }
        willMove(toParent: nil)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            self.view.alpha = 0.0
        } completion: { _ in
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
    }
}
