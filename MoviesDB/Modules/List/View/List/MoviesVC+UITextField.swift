//
//  MoviesVC+UITextField.swift
//  MoviesDB
//
//  Created by Ferdinand on 18/11/22.
//

import UIKit

extension MoviesVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.3, delay: 0, options: [.transitionCrossDissolve], animations: {
                guard self.cancelButton.isHidden else { return }
                self.cancelButton.isHidden = false
                self.cancelButton.alpha = 1
                self.view.layoutIfNeeded()
            })
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        cancelButtonTapped(self.cancelButton)
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        self.presenter?.searchMovies(text)
    }
}
