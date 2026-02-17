//
//  MoviesVC.swift
//  MoviesDB
//
//  Created by Ferdinand on 18/11/22.
//

import UIKit
import SwiftUI

class MainVC: UIViewController {
    
    private(set) lazy var hostingController: UIHostingController = UIHostingController(rootView: MainView())
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initLayout()
        self.hideKeyboardWhenTappedAround()
    }

    // MARK: Initialize
    private func initView() {
        addChild(hostingController)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
    }

    private func initLayout() {
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
