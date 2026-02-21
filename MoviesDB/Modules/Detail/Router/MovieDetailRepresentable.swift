//
//  MovieDetailRepresentable.swift
//  MoviesDB
//
//  Created by Ferdinand Tedjakusuma on 21/02/26.
//

import Foundation
import UIKit
import SwiftUI

struct MovieDetailRepresentable: UIViewControllerRepresentable {
   
    typealias UIViewControllerType = UIViewController
    
    private(set) var movieId: String
    
    init(_ id: String) {
        self.movieId = id
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = MovieDetailRouter.assembleModule(movieId)
        return controller
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) { }
}
