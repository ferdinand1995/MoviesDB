//
//  UICoordinator.swift
//  MoviesDB
//
//  Created by Ferdinand Tedjakusuma on 21/02/26.
//

import Foundation
import SwiftUI

@Observable
@MainActor
class UICoordinator {
    var scrollView: UIScrollView = .init(frame: .zero)
    var rect: CGRect = .zero
    var animationImage: UIImage?
    var animationView: Bool = false
    var hideLayer: Bool = false
    var hideRootView: Bool = false
}

struct ScrollViewExtractor: UIViewRepresentable {
    typealias UIViewType = UIView
    var result: (UIScrollView) -> ()

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false

        DispatchQueue.main.async {
            if let scrollView = view.superview?.superview?.superview as? UIScrollView {
                result(scrollView)
            }
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
