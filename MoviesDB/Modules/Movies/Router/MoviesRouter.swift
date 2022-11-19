//
//  MoviesRouter.swift
//  MoviesDB
//
//  Created by Ferdinand on 18/11/22.
//

import UIKit

final class MoviesRouter: MoviesWireframe {
    
    weak var viewController: UIViewController?
    
    static func assembleModule() -> UIViewController {
        let view = MoviesVC()
        let router = MoviesRouter()
        
        let navigation = UINavigationController(rootViewController: view)
                
        router.viewController = view
        
        return navigation
    }
}
