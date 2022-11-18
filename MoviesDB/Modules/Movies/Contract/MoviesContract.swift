//
//  MoviesContract.swift
//  MoviesDB
//
//  Created by Ferdinand on 18/11/22.
//

import Foundation
//
//  ArticlesContract.swift
//  Articles
//
//  Created by Pedro Henrique Prates Peralta on 21/01/17.
//  Copyright © 2017 Pedro Peralta. All rights reserved.
//

import UIKit

protocol MoviesView: AnyObject {
    
}

protocol MoviesPresentation: AnyObject {
   
}

protocol MoviesUseCase: AnyObject {
    
}

protocol MoviesInteractorOutput: AnyObject {
    
}

protocol MoviesWireframe: AnyObject {
    var viewController: UIViewController? { get set }
        
    static func assembleModule() -> UIViewController
}
